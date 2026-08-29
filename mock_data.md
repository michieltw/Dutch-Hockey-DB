# Mock Data Examples

This document serves as a repository for mock data structures (JSON/SQL inserts) that correspond to the Benelux Ice Hockey Database Schema. It will be progressively filled as needed for testing purposes.

## 1. The Party Model & External Linking
*Example of a person acting as a player, linked to an external IJNL database ID.*

```json
{
  "person": {
    "id": "uuid-1234-abcd",
    "first_name": "Johan",
    "last_name": "de Vries",
    "birth_date": "2001-05-14",
    "nationality": "NL",
    "email": "johan.devries@example.com",
    "created_at": "2024-01-01T10:00:00Z"
  },
  "player_profile": {
    "id": "uuid-5678-efgh",
    "person_id": "uuid-1234-abcd",
    "shoots": "L",
    "position": "Center",
    "player_role": "Playmaker"
  },
  "external_link": {
    "entity_type": "player",
    "internal_id": "uuid-5678-efgh",
    "source_system": "IJNL",
    "external_id": "BND-987654321"
  }
}
```

## 2. Organizations & Branding
*Example of a club with abbreviation and logo requirements.*

```json
{
  "organization": {
    "id": "uuid-org-001",
    "name": "GIJS Groningen",
    "abbreviation": "GIJS",
    "ini_code": "GRON",
    "organization_type": "Club",
    "founded_year": 1969,
    "logo_url": "https://example.com/logos/gijs-groningen.png"
  }
}
```

## 3. Player Equipment & Stick Performance
*Example of highly detailed stick tracking and degradation.*

```json
{
  "player_stick": {
    "id": "uuid-stick-001",
    "player_id": "uuid-5678-efgh",
    "brand": "Bauer",
    "model": "Nexus Sync",
    "year_purchased": 2023,
    "condition": "Used",
    "flex": 77,
    "curve": "P92",
    "color": "Black/Blue",
    "weight_grams": 365,
    "length_inches": 60,
    "composition": "Carbon Fiber",
    "age_category": "Senior",
    "status": "Currently Used"
  },
  "stick_performance_log": {
    "stick_id": "uuid-stick-001",
    "logged_date": "2024-02-15",
    "games_played_with": 12,
    "practices_used": 24,
    "estimated_performance_score": 85.5,
    "notes": "Starting to lose some pop on slapshots, still good for wristers."
  }
}
```
