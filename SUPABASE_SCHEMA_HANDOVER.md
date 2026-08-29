# AI Handover Document: Supabase Database Schema Generation

## Context & Purpose
You are tasked with generating the physical PostgreSQL (Supabase) database schema for the **Benelux Ice Hockey Ecosystem**. A comprehensive list of proposed tables can be found in `database_tables.md`.

This database is designed to be the most extensive representation of a regional ice hockey ecosystem ever built. It spans across core entities, live scoring, complex contracts, youth development, gamification, and historical archiving.

Your output must consist of robust, production-ready SQL statements (DDL) that create these tables, configure relationships, and define constraints appropriate for Supabase.

## Core Directives for the AI Engineer

### 1. Naming Conventions & Types
- **Tables & Columns:** Everything MUST be in `snake_case`. Pluralize table names (e.g., `players`, `teams`), and use singular names for columns (e.g., `team_id`, `first_name`).
- **Primary Keys:** Use `id UUID DEFAULT gen_random_uuid() PRIMARY KEY` for nearly all tables, unless a composite key is logically superior (e.g., for mapping tables like `player_achievements`).
- **Timestamps:** Every core table MUST include `created_at TIMESTAMPTZ DEFAULT NOW()` and `updated_at TIMESTAMPTZ`.
- **Enums:** Use PostgreSQL ENUM types generously for fields with known, fixed values.
  - *Example:* Instead of a text field for `player_role`, create an enum: `CREATE TYPE player_role_enum AS ENUM ('Sniper', 'Playmaker', 'Grinder', 'Two-Way', 'Enforcer');`.
  - *Example:* `CREATE TYPE shot_type_enum AS ENUM ('Slap', 'Wrist', 'Snap', 'Backhand', 'Tip-in');`.

### 2. Relationship Structure & Foreign Keys
The relational integrity of this database is paramount. You must think deeply about how tables connect.
- Define explicit `FOREIGN KEY` relationships using standard PostgreSQL syntax (`REFERENCES table(id)`).
- **On Delete Behaviors:** Think critically about `ON DELETE CASCADE` vs. `ON DELETE SET NULL` vs `ON DELETE RESTRICT`.
  - *Example:* If a `league` is deleted, its `seasons` should probably cascade. But if a `player` is deleted (or merged), their `goals` should likely just have the `player_id` set to `NULL` to preserve historical integrity, or be restricted.
- **Mapping Tables:** Implement robust many-to-many relationship tables.
  - *Example:* A player can have many agents over time. Use a `player_agent_relationships` table with `start_date` and `end_date` rather than a single `agent_id` on the `players` table.

### 3. Extremely Detailed Fields
Do not create skeletal tables. You must generate an exhaustive list of fields for each table, anticipating advanced analytics and edge cases.
- *Example (Players):* Do not just add `height` and `weight`. Add `shoots` (L/R), `catches` (L/R for goalies), `birth_city`, `birth_country`, `draft_year`, `draft_overall_pick`.
- *Example (Goals):* Do not just add `scorer_id` and `time`. Add `primary_assist_id`, `secondary_assist_id`, `shot_type`, `distance_to_net`, `x_coordinate`, `y_coordinate`, `is_empty_net`, `is_powerplay`, `is_shorthanded`.
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