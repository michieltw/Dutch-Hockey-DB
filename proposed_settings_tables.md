# Proposed Settings & Configuration Tables

This document outlines a comprehensive, highly-structured database schema for settings and configurations within the Benelux Ice Hockey platform. It includes real-world management settings (supporting both NA and EU models), granular Role-Based Access Control (RBAC), complex league/game rules, draft setups, tournament configurations, and competitive balancing features (e.g., virtual salary caps).

## 1. Role-Based Access Control (RBAC) & Permissions
*To provide exact mapping and granular control over what League Managers, Team Managers, and other roles can do.*

- **`permissions`**
  - `id` UUID PK
  - `name` VARCHAR (e.g., 'approve_trade', 'edit_roster', 'configure_league_rules')
  - `description` TEXT
  - `module` VARCHAR (e.g., 'Trades', 'League', 'GameDay', 'Settings')
  - *Standard Timestamps & Soft Deletes*

- **`role_permissions`**
  - `id` UUID PK
  - `role` user_role_enum (from `00_enums.sql`)
  - `permission_id` UUID FK
  - `is_allowed` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

- **`user_custom_permissions`**
  *For overriding specific user permissions outside their base role.*
  - `id` UUID PK
  - `user_id` UUID FK
  - `permission_id` UUID FK
  - `is_allowed` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

## 2. User & App Settings
*Configuration for general application behavior and manager-specific preferences.*

- **`user_app_settings`**
  - `id` UUID PK
  - `user_id` UUID FK (Unique)
  - `ui_theme` theme_enum
  - `language` VARCHAR (e.g., 'nl', 'en', 'fr')
  - `timezone` VARCHAR
  - `email_notifications` BOOLEAN
  - `push_notifications` BOOLEAN
  - `visibility` profile_visibility_enum
  - *Standard Timestamps & Soft Deletes*

- **`manager_preferences`**
  - `id` UUID PK
  - `user_id` UUID FK (Unique)
  - `auto_accept_minor_trades` BOOLEAN
  - `trade_block_visible` BOOLEAN
  - `ai_assistant_enabled` BOOLEAN
  - `preferred_scouting_region` UUID FK (links to `regions`)
  - `default_contract_length` INT
  - *Standard Timestamps & Soft Deletes*

## 3. League & Competition Settings
*Highly detailed configurations for how a league operates, spanning real-life gameplay rules to NA/EU structural differences.*

- **`league_game_rules_settings`**
  - `id` UUID PK
  - `league_id` UUID FK (Unique)
  - `period_length_minutes` INT (e.g., 20)
  - `number_of_periods` INT (e.g., 3)
  - `minor_penalty_minutes` INT (e.g., 2)
  - `major_penalty_minutes` INT (e.g., 5)
  - `misconduct_penalty_minutes` INT (e.g., 10)
  - `overtime_format` overtime_format_enum
  - `overtime_length_minutes` INT
  - `shootout_enabled` BOOLEAN
  - `shootout_rounds` INT
  - `points_for_win` INT (e.g., 2 or 3)
  - `points_for_ot_win` INT
  - `points_for_ot_loss` INT
  - `icing_rule` icing_rule_enum
  - *Standard Timestamps & Soft Deletes*

- **`league_roster_rules_settings`**
  - `id` UUID PK
  - `league_id` UUID FK (Unique)
  - `max_active_roster` INT
  - `min_active_roster` INT
  - `max_dressed_game` INT (e.g., 20)
  - `max_dressed_goalies` INT (e.g., 2)
  - `max_imports` INT
  - `min_age_eligible` INT
  - `max_age_eligible` INT
  - `allow_age_dispensations` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

- **`league_financial_settings`**
  *Used for both real salaries and "competitive balancing" points/virtual salaries without actual pay.*
  - `id` UUID PK
  - `league_id` UUID FK (Unique)
  - `salary_cap_enabled` BOOLEAN
  - `salary_cap_hard_limit` NUMERIC
  - `salary_cap_floor` NUMERIC
  - `luxury_tax_enabled` BOOLEAN
  - `use_virtual_contracts` BOOLEAN (For gamified balancing without real money)
  - `max_contract_length_years` INT
  - `allow_retained_salary` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

- **`transfer_window_settings`**
  - `id` UUID PK
  - `league_id` UUID FK
  - `window_type` transfer_window_type_enum
  - `start_date` TIMESTAMPTZ
  - `end_date` TIMESTAMPTZ
  - `trade_deadline` TIMESTAMPTZ
  - `allow_loans` BOOLEAN
  - `allow_international_transfers` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

## 4. Draft Settings
*Detailed setups for North American style drafts or European academy structures.*

- **`draft_settings`**
  - `id` UUID PK
  - `league_id` UUID FK
  - `season_id` UUID FK
  - `number_of_rounds` INT
  - `time_limit_per_pick_seconds` INT
  - `draft_format` draft_format_enum
  - `lottery_enabled` BOOLEAN
  - `min_eligible_birth_year` INT
  - `max_eligible_birth_year` INT
  - `allow_pick_trading` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

- **`draft_lottery_settings`**
  - `id` UUID PK
  - `draft_settings_id` UUID FK
  - `lottery_type` lottery_type_enum
  - `number_of_lottery_winners` INT
  - `max_spots_moved_up` INT
  - *Standard Timestamps & Soft Deletes*

## 5. Tournament & Event Settings
*Configurations for specific tournaments, playoffs, and pre-game setups.*

- **`tournament_settings`**
  - `id` UUID PK
  - `tournament_id` UUID FK (Unique)
  - `format` tournament_format_enum
  - `tiebreaker_1` tiebreaker_enum
  - `tiebreaker_2` tiebreaker_enum
  - `tiebreaker_3` tiebreaker_enum
  - `group_count` INT
  - `teams_advancing_per_group` INT
  - *Standard Timestamps & Soft Deletes*

- **`pre_game_settings`**
  - `id` UUID PK
  - `league_id` UUID FK (or `tournament_id` FK)
  - `warmup_duration_minutes` INT
  - `anthem_required` BOOLEAN
  - `roster_lock_minutes_before_puck_drop` INT
  - `starting_lineup_announcement_required` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

## 6. Gamification & Social Settings
*Settings to toggle social and gamified interactive elements around the real-life management.*

- **`gamification_settings`**
  - `id` UUID PK
  - `league_id` UUID FK
  - `achievements_enabled` BOOLEAN
  - `fan_predictions_enabled` BOOLEAN
  - `leaderboard_visible` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

- **`social_privacy_settings`**
  - `id` UUID PK
  - `user_id` UUID FK
  - `allow_direct_messages` BOOLEAN
  - `show_online_status` BOOLEAN
  - `share_activity_feed` BOOLEAN
  - *Standard Timestamps & Soft Deletes*

## 7. Proposed Enums to Support Settings

To be appended or added alongside the enums in `individual_schemas/00_enums.sql`:

```sql
CREATE TYPE theme_enum AS ENUM ('Light', 'Dark', 'System');
CREATE TYPE profile_visibility_enum AS ENUM ('Public', 'Friends Only', 'Private');
CREATE TYPE overtime_format_enum AS ENUM ('3v3', '4v4', '5v5', 'Continuous 5v5', 'None');
CREATE TYPE icing_rule_enum AS ENUM ('Touch', 'No-Touch', 'Hybrid');
CREATE TYPE transfer_window_type_enum AS ENUM ('Off-season', 'Mid-season', 'Emergency');
CREATE TYPE draft_format_enum AS ENUM ('Standard', 'Snake', 'Auction');
CREATE TYPE lottery_type_enum AS ENUM ('Weighted', 'Equal', 'Tiered');
CREATE TYPE tournament_format_enum AS ENUM ('Round Robin', 'Knockout', 'Double Elimination', 'Group Stage to Knockout');
CREATE TYPE tiebreaker_enum AS ENUM ('Points', 'Regulation Wins', 'Head-to-Head', 'Goal Differential', 'Goals For', 'Coin Toss');
```
