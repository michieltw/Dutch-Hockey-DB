# AI Handover Document: Supabase Database Schema Generation

## Context & Purpose
You are tasked with generating the physical PostgreSQL (Supabase) database schema for the **Benelux Ice Hockey Ecosystem**. A comprehensive list of proposed tables can be found in `database_tables.md`.

This database is designed to be the most extensive representation of a regional ice hockey ecosystem ever built. It spans across core entities, live scoring, complex contracts, youth development, gamification, and historical archiving.

Your output must consist of robust, production-ready SQL statements (DDL) that create these tables, configure relationships, and define constraints appropriate for Supabase.

## Core Directives for the AI Engineer

### 1. Naming Conventions, Types, & Standard Fields
- **Tables & Columns:** Everything MUST be in `snake_case`. Pluralize table names (e.g., `players`, `teams`), and use singular names for columns (e.g., `team_id`, `first_name`).
- **Primary Keys:** Use `id UUID DEFAULT gen_random_uuid() PRIMARY KEY` for nearly all tables, unless a composite key is logically superior (e.g., for mapping tables like `player_achievements`).
- **Timestamps & Soft Deletes:** Every table MUST include `created_at TIMESTAMPTZ DEFAULT NOW()`, `updated_at TIMESTAMPTZ`, and crucially, **`deleted_at TIMESTAMPTZ`**. We must *soft delete* records to maintain historical integrity. Do not drop records completely.
- **Abbreviations & INI Codes:** Where applicable, tables should include an `abbreviation` field (e.g., "AMS" for Amsterdam) and the database architecture should assign a 4-letter INI-style code/prefix to tables or records for short-hand identification.
- **Logos & Images:** Any entity that could have a visual representation (clubs, teams, sponsors, users, products, arenas) must have a `logo_url` or `image_url` field.
- **Enums:** Use PostgreSQL ENUM types generously for fields with known, fixed values.
  - *Example:* Instead of a text field for `player_role`, create an enum: `CREATE TYPE player_role_enum AS ENUM ('Sniper', 'Playmaker', 'Grinder', 'Two-Way', 'Enforcer');`.
  - *Example:* `CREATE TYPE shot_type_enum AS ENUM ('Slap', 'Wrist', 'Snap', 'Backhand', 'Tip-in');`.

### 2. Architectural Paradigms & Relationships
The relational integrity of this database is paramount. You must think deeply about how tables connect.
- **The Party Model:** Do not duplicate human or organizational data. Create a central `persons` table (holding first name, last name, DOB, contact). The `players`, `coaches`, and `users` tables should just have a `person_id` foreign key. Do the same for `organizations` (clubs, federations, sponsors).
- **External Database Linking:** We pull data from public sources like IJshockey Nederland (IJNL). Include fields like `ijnl_id` or `elite_prospects_id` on relevant tables (or use an `external_links` mapping table) to bind our records to external unique IDs.
- Define explicit `FOREIGN KEY` relationships using standard PostgreSQL syntax (`REFERENCES table(id)`).
- **On Delete Behaviors:** Think critically about `ON DELETE CASCADE` vs. `ON DELETE SET NULL` vs `ON DELETE RESTRICT`.
  - *Example:* If a `league` is deleted, its `seasons` should probably cascade. But if a `player` is deleted (or merged), their `goals` should likely just have the `player_id` set to `NULL` to preserve historical integrity, or be restricted.
- **Mapping Tables:** Implement robust many-to-many relationship tables.
  - *Example:* A player can have many agents over time. Use a `player_agent_relationships` table with `start_date` and `end_date` rather than a single `agent_id` on the `players` table.

### 3. Extremely Detailed Fields
Do not create skeletal tables. You must generate an exhaustive list of fields for each table, anticipating advanced analytics and edge cases.
- *Example (Players):* Do not just add `height` and `weight`. Add `shoots` (L/R), `catches` (L/R for goalies), `birth_city`, `birth_country`, `draft_year`, `draft_overall_pick`.
- *Example (Goals):* Do not just add `scorer_id` and `time`. Add `primary_assist_id`, `secondary_assist_id`, `shot_type`, `distance_to_net`, `x_coordinate`, `y_coordinate`, `is_empty_net`, `is_powerplay`, `is_shorthanded`.
- *Example (Equipment/Sticks):* Users will track specific gear. A `player_sticks` table needs fields for: `brand`, `model`, `year_purchased`, `condition` (enum), `flex`, `curve`, `color`, `weight_grams`, `length_inches`, `composition`, `age_category` (senior, int, jr, youth), and `status` (currently used, previously used, wish list). You must also link this to a `stick_performance_logs` table that tracks an estimated overall performance score that degrades based on activity and stick rotation.
- Use the concepts outlined in `database_tables.md` (e.g., NHL EDGE stats, contract clauses, IIHF rules) to inspire the breadth of your columns.

### 4. CRUCIAL WARNING: Nullability / Required Fields
**Be extremely conservative with `NOT NULL` constraints.**
Because this ecosystem encompasses everything from fully professional leagues down to U9 recreational youth hockey, data sparsity is guaranteed.
- A professional `contract` will have complex salary retention data; a youth player's `contract` will not.
- We may only have a player's first and last name, without knowing their birth date or height.
- **Rule of Thumb:** Make only the absolute bare minimum fields `NOT NULL`. Usually, this is just the `id`, critical structural foreign keys (e.g., a `roster_spot` MUST have a `team_id`), and fundamental identifiers (e.g., a `player` MUST have a `first_name` and `last_name`). Almost everything else (`height`, `jersey_number`, `birth_date`, specific stats) **MUST BE NULLABLE**.

### 5. Supabase Specifics
- **Row Level Security (RLS):** For every table created, append `ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;`. Do not write the actual policies yet, but ensure RLS is enabled by default to secure the database.
- Ensure all syntax is strictly compatible with standard PostgreSQL 15+.

## Execution Strategy
When executing the creation of this database:
1. **Phase 1: Enums & Base Types.** Create all ENUMs first.
2. **Phase 2: Core Entities.** Create standalone tables without dependencies (e.g., `regions`, `nationalities`, `federations`).
3. **Phase 3: Relational Entities.** Create tables that depend on Core Entities (e.g., `clubs` referencing `federations`, `players`, `arenas`).
4. **Phase 4: Transactional & Event Data.** Create highly relational tables (e.g., `contracts`, `games`, `goals`, `penalties`).
5. **Phase 5: Join/Mapping Tables.** Create the complex many-to-many structures.

Proceed methodically, validating foreign key constraints step-by-step.