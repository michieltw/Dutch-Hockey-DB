import argparse
import json
import sys
from playwright.sync_api import sync_playwright
import re

def scrape_team_data(competition_id: str, team_id: str):
    """
    Scrapes the ijshockey.nl website for a specific team in a competition
    to extract player data.
    """
    url = f'https://www.ijshockey.nl/competities/team/{competition_id}/{team_id}'

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        try:
            page.goto(url, wait_until='networkidle')

            try:
                page.wait_for_selector('.tableportrait', timeout=10000)
            except Exception as e:
                print(f"Error: Table data did not load within timeout: {e}", file=sys.stderr)
                browser.close()
                return None

            team_info = {
                'team_id': team_id,
                'competition_id': competition_id,
                'players': []
            }

            rows = page.locator("tr")
            count = rows.count()

            for i in range(count):
                row = rows.nth(i)
                player_link = row.locator(f"a[href*='/competities/speler/{competition_id}/']")
                if player_link.count() > 0:
                    href = player_link.first.get_attribute("href")
                    if href:
                        match = re.search(r'/speler/\d+/(\d+)', href)
                        if match:
                            player_id = match.group(1)

                            name_element = row.locator(".playername")
                            player_name = name_element.inner_text().strip() if name_element.count() > 0 else "Unknown"

                            tds = row.locator("td")
                            td_texts = [td.inner_text().strip() for j in range(tds.count()) for td in [tds.nth(j)]]

                            position = "Unknown"
                            for text in td_texts:
                                if text in ['F', 'D', 'G', 'C', 'RW', 'LW', 'RD', 'LD']:
                                    position = text
                                    break

                            team_info['players'].append({
                                'player_id': player_id,
                                'name': player_name,
                                'position': position,
                                'profile_url': f"https://www.ijshockey.nl{href}"
                            })

            browser.close()
            return team_info

        except Exception as e:
            print(f"Scraping failed: {e}", file=sys.stderr)
            browser.close()
            return None

def scrape_player_data(competition_id: str, player_id: str):
    """
    Scrapes the ijshockey.nl website for a specific player's statistics.
    """
    url = f'https://www.ijshockey.nl/competities/speler/{competition_id}/{player_id}'

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()

        try:
            page.goto(url, wait_until='networkidle')

            try:
                page.wait_for_selector('table', timeout=8000)
            except:
                pass

            player_info = {
                'player_id': player_id,
                'competition_id': competition_id,
                'stats_summary': {},
                'competitions': []
            }

            stats_row = page.locator('.stats-row > div')
            if stats_row.count() > 0:
                for i in range(stats_row.count()):
                    div = stats_row.nth(i)
                    inner_divs = div.locator('div')
                    if inner_divs.count() >= 2:
                        key = inner_divs.nth(0).inner_text().strip()
                        val = inner_divs.nth(1).inner_text().strip()
                        player_info['stats_summary'][key] = val

            tables = page.locator("table")
            table_count = tables.count()

            for i in range(table_count):
                table = tables.nth(i)
                headers = table.locator("th")
                if headers.count() == 0:
                    continue

                header_texts = [headers.nth(h).inner_text().strip() for h in range(headers.count())]
                rows = table.locator("tbody tr")

                for r in range(rows.count()):
                    row = rows.nth(r)
                    tds = row.locator("td")
                    td_texts = [tds.nth(t).inner_text().strip() for t in range(tds.count())]

                    row_data = {}
                    for idx, header in enumerate(header_texts):
                        if idx < len(td_texts) and header:
                            row_data[header] = td_texts[idx]

                    if row_data:
                        player_info['competitions'].append(row_data)

            browser.close()
            return player_info

        except Exception as e:
            print(f"Scraping failed: {e}", file=sys.stderr)
            browser.close()
            return None


def main():
    parser = argparse.ArgumentParser(description='Scrape data from ijshockey.nl')
    parser.add_argument('--competition-id', type=str, required=True, help='The competition ID (e.g., 22086)')

    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--team-id', type=str, help='The team ID to scrape (e.g., 40216)')
    group.add_argument('--player-id', type=str, help='The player ID to scrape (e.g., 156638)')

    parser.add_argument('--output', type=str, help='Output JSON file path (optional, otherwise prints to stdout)')

    args = parser.parse_args()

    data = None
    if args.team_id:
        data = scrape_team_data(args.competition_id, args.team_id)
    elif args.player_id:
        data = scrape_player_data(args.competition_id, args.player_id)

    if data:
        result_json = json.dumps(data, indent=2, ensure_ascii=False)
        if args.output:
            with open(args.output, 'w', encoding='utf-8') as f:
                f.write(result_json)
            print(f"Data successfully written to {args.output}")
        else:
            print(result_json)
    else:
        print("No data found or scraping failed.", file=sys.stderr)
        sys.exit(1)

if __name__ == '__main__':
    main()
