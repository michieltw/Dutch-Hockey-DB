# Benelux Ice Hockey Ecosystem - Database Tables

This document contains an extensive, Supabase-compatible (`snake_case`) list of potential database tables for a comprehensive Benelux Ice Hockey platform. The tables are grouped by an updated category structure to accommodate highly specific data from local federations (IJshockey Nederland), international bodies (IIHF), extensive statistical platforms (Elite Prospects, HockeyDB), professional tracking (NHL EDGE), and simulation concepts (EA NHL, Franchise Hockey Manager).

The tables include functional tags to indicate their primary domain.

## 1. Core Entities & Infrastructure (The Party Model)
*Foundational data for the hockey ecosystem. We use a central 'Party Model' for persons and organizations.*

- `persons` [Core] (Central record for a human: Name, DOB. Links to players, coaches, fans)
- `organizations` [Core] (Central record for entities: Clubs, federations, sponsors)
- `federations` [Core]
- `clubs` [Core]
- `teams` [Core]
- `arenas` [Core]
- `rinks` [Core]
- `coaches` [Core]
- `staff` [Core]
- `team_staff` [Core]
- `rosters` [Core]
- `nationalities` [Core]
- `regions` [Core]
- `affiliations` [Core]
- `club_hierarchies` [Core]
- `external_links` [Core] (To store mappings to external databases like IJshockey Nederland IDs)

## 2. Player Profiles, Demographics & Attributes
*Expanded player data inspired by Elite Prospects, HockeyDB, and video game simulation mechanics.*

- `players` [Core]
- `player_history` [Core]
- `family_connections` [Demographics] (e.g., father, brother, son)
- `agents` [Demographics]
- `agencies` [Demographics]
- `player_agent_relationships` [Demographics]
- `career_milestones` [Demographics]
- `alumni_associations` [Demographics]
- `hall_of_fame_inductions` [Demographics]
- `national_team_selections` [Demographics]
- `player_attributes` [Scouting] (Granular skills: speed, checking, awareness)
- `player_roles` [Scouting] (e.g., Sniper, Playmaker, Grinder, Two-Way)

## 3. Competitions, Leagues & Rosters
*Structure of leagues, tournaments, and specific local roster rules (e.g., IJshockey Nederland age dispensations).*

- `leagues` [Core]
- `seasons` [Core]
- `divisions` [Core]
- `conferences` [Core]
- `tournaments` [Core]
- `cups` [Core]
- `phases` [Core]
- `series` [Core]
- `standings` [Core]
- `tiebreakers` [Core]
- `relegation_rules` [Core]
- `bracket_matchups` [Core]
- `wildcard_standings` [Core]
- `age_categories` [Competitions] (U9, U11, U13, etc.)
- `age_dispensations` [Competitions] (Dispensatieregeling)
- `import_quotas` [Competitions]

## 4. Game Day Operations & Volunteering
*Logistics of running a game, highly relevant to local clubs like GIJS Groningen.*

- `game_day_roles` [Operations]
- `volunteers` [Operations]
- `volunteer_assignments` [Operations] (e.g., Tafeljury, Strafbank, Speaker, DJ)
- `digital_game_sheets` [Operations] (Digitaal Wedstrijdformulier - DWF)
- `game_sheet_signatures` [Operations]
- `security_personnel` [Operations]
- `ice_resurfacing_schedule` [Operations]

## 5. Live Scoring & In-Game Events
*Comprehensive live scoring system and detailed in-game event tracking.*

- `games` [Live Scoring]
- `game_officials` [Live Scoring]
- `periods` [Live Scoring]
- `lineups` [Live Scoring]
- `starting_lineups` [Live Scoring]
- `events` [Live Scoring]
- `goals` [Live Scoring]
- `assists` [Live Scoring]
- `penalties` [Live Scoring]
- `shots` [Live Scoring]
- `faceoffs` [Live Scoring]
- `hits` [Live Scoring]
- `blocked_shots` [Live Scoring]
- `shifts` [Live Scoring]
- `giveaways` [Live Scoring]
- `takeaways` [Live Scoring]
- `icings` [Live Scoring]
- `offsides` [Live Scoring]
- `time_outs` [Live Scoring]
- `shootouts` [Live Scoring]
- `video_reviews` [Live Scoring]
- `goaltender_stats` [Live Scoring]
- `player_game_stats` [Live Scoring]
- `team_game_stats` [Live Scoring]
- `unified_game_events` [Live Scoring]

## 6. Advanced Stats & Tracking Analytics
*Granular statistics, advanced metrics, and physics tracking data (inspired by NHL EDGE).*

- `advanced_player_metrics` [Analytics] (e.g. Corsi, Fenwick, PDO)
- `advanced_team_metrics` [Analytics]
- `zone_starts` [Analytics]
- `zone_entries` [Analytics]
- `zone_exits` [Analytics]
- `shot_locations` [Analytics] (x, y coordinates)
- `puck_tracking_data` [Analytics]
- `player_tracking_data` [Analytics]
- `expected_goals` [Analytics]
- `passing_metrics` [Analytics]
- `faceoff_win_percentages` [Analytics]
- `skating_speed_records` [Analytics]
- `shot_speed_records` [Analytics]
- `distance_traveled` [Analytics]

## 7. Regulatory, Compliance & Rules (IIHF/Local)
*Tables for ensuring safety, integrity, IIHF rulebooks, and federation memberships.*

- `federation_memberships` [Compliance] (Bondsnummers)
- `rulebooks` [Compliance] (IIHF, Local)
- `rule_versions` [Compliance]
- `rule_changes` [Compliance]
- `international_transfer_cards` [Compliance] (ITCs)
- `rink_specifications` [Compliance] (Dimensions, Glass height)
- `equipment_specifications` [Compliance] (Visor mandates, neck guards)
- `anti_doping_records` [Compliance]
- `safeguarding_logs` [Compliance] (VOGs in NL)
- `safe_sport_certifications` [Compliance]
- `official_evaluations` [Compliance]
- `training_certifications` [Compliance]
- `incident_reports` [Compliance]
- `appeals` [Compliance]
- `suspensions` [Compliance]
- `disciplinary_hearings` [Compliance]

## 8. Contracts, Transfers & Administration
*Handling complex transactions spanning North American and European rules.*

- `licenses` [Administration]
- `license_types` [Administration]
- `transfers` [Administration]
- `transfer_rules` [Administration]
- `transfer_rumors` [Administration] (Elite Prospects style)
- `contracts` [Administration]
- `contract_clauses` [Administration] (NMC, NTC)
- `salaries` [Administration]
- `retained_salaries` [Administration]
- `salary_caps` [Administration]
- `waivers` [Administration]
- `buyouts` [Administration]
- `loan_agreements` [Administration] (EU specific)
- `two_way_contracts` [Administration]
- `officials` [Administration]
- `referee_assignments` [Administration]
- `insurance_policies` [Administration]
- `background_checks` [Administration]

## 9. Club Management & Coaching
*Day-to-day operations, finances, and strategic coaching.*

- `sponsors` [Management]
- `sponsorship_deals` [Management]
- `sponsorships` [Management]
- `advertising_inventory` [Management]
- `club_finances` [Management]
- `invoices` [Management]
- `budgets` [Management]
- `expenses` [Management]
- `travel_itineraries` [Management]
- `transportation_logs` [Management]
- `accommodation_bookings` [Management]
- `staff_schedules` [Management]
- `youth_academies` [Management]
- `academy_enrollments` [Management]
- `regional_talent_centers` [Management] (RTCs / Nationale Trainingscentra)
- `coaching_strategies` [Coaching] (Systems like 1-3-1, Trap, Dump & Chase)

## 10. Player Development & Scouting
*Training, evaluation, scouting rankings, and player health.*

- `training_sessions` [Development]
- `practice_attendance` [Development]
- `drills` [Development]
- `skill_evaluations` [Development]
- `development_plans` [Development]
- `fitness_tests` [Development]
- `scouts` [Development]
- `scouting_reports` [Development]
- `player_ratings` [Development]
- `draft_prospects` [Development]
- `draft_rankings` [Development] (Elite Prospects style)
- `draft_picks` [Development]
- `injuries` [Development]

## 11. Facilities, Maintenance & Player Equipment
*Arena operations, general equipment, and specific player gear tracking.*

- `locker_rooms` [Facilities]
- `locker_assignments` [Facilities]
- `ice_maintenance_logs` [Facilities]
- `zamboni_schedules` [Facilities]
- `facility_bookings` [Facilities]
- `equipment_inventory` [Facilities]
- `equipment_repairs` [Facilities]
- `skate_sharpening_logs` [Facilities]
- `safety_inspections` [Facilities]
- `player_sticks` [Equipment] (Brand, model, year, condition, flex, curve, color, weight, length, composition, age category)
- `stick_performance_logs` [Equipment] (Tracks degradation over time based on activity/level)
- `player_skates` [Equipment]
- `player_protective_gear` [Equipment]

## 12. Social, Community & Networking
*Social network features for fans, players, and clubs.*

- `users` [Social]
- `profiles` [Social]
- `friendships` [Social]
- `follows` [Social]
- `posts` [Social]
- `comments` [Social]
- `likes` [Social]
- `shares` [Social]
- `messages` [Social]
- `chat_rooms` [Social]
- `forum_categories` [Social]
- `forum_topics` [Social]
- `forum_replies` [Social]
- `polls` [Social]
- `poll_votes` [Social]
- `club_memberships` [Social]
- `fan_clubs` [Social]
- `user_roles` [Social]

## 13. Marketplace & Ticketing
*Merchandise, ticket sales, and second-hand equipment.*

- `products` [Marketplace]
- `categories` [Marketplace]
- `brands` [Marketplace]
- `sellers` [Marketplace]
- `inventory` [Marketplace]
- `orders` [Marketplace]
- `order_items` [Marketplace]
- `payments` [Marketplace]
- `shipping` [Marketplace]
- `reviews` [Marketplace]
- `shopping_carts` [Marketplace]
- `wishlists` [Marketplace]
- `classified_ads` [Marketplace]
- `bids` [Marketplace]
- `tickets` [Ticketing]
- `season_tickets` [Ticketing]
- `ticket_packages` [Ticketing]
- `ticket_scans` [Ticketing]
- `seating_charts` [Ticketing]
- `sections` [Ticketing]
- `rows` [Ticketing]
- `seats` [Ticketing]

## 14. Gamification
*Interactive features and fan engagement.*

- `achievements` [Gamification]
- `badges` [Gamification]
- `user_achievements` [Gamification]
- `player_achievements` [Gamification]
- `points_ledger` [Gamification]
- `leaderboards` [Gamification]
- `quests` [Gamification]
- `rewards` [Gamification]
- `predictions` [Gamification]
- `prediction_results` [Gamification]
- `trivia_questions` [Gamification]
- `trivia_answers` [Gamification]

## 15. Media, Broadcasting & History
*News, editorial content (Face-off NL style), historical records, and awards.*

- `articles` [Media]
- `authors` [Media]
- `editorial_columns` [Media]
- `match_previews` [Media]
- `match_reports` [Media]
- `interviews` [Media]
- `newsletters` [Media]
- `galleries` [Media]
- `photos` [Media]
- `videos` [Media]
- `live_streams` [Media]
- `broadcast_schedules` [Media]
- `commentators` [Media]
- `highlights` [Media]
- `tags` [Media]
- `press_releases` [Media]
- `podcasts` [Media]
- `podcast_episodes` [Media]
- `awards` [History]
- `trophies` [History]
- `award_winners` [History]
- `historical_records` [History] (e.g., most goals in a season)
- `championship_banners` [History]
