# Benelux Ice Hockey Ecosystem - Database Tables

This document contains an extensive, Supabase-compatible (`snake_case`) list of potential database tables for a comprehensive Benelux Ice Hockey platform. The tables are grouped by category and include functional tags to indicate their primary domain.

## 1. Core Entities & Infrastructure
*These tables form the foundational data for the hockey ecosystem.*

- `federations` [Core]
- `clubs` [Core]
- `teams` [Core]
- `arenas` [Core]
- `rinks` [Core]
- `players` [Core]
- `coaches` [Core]
- `staff` [Core]
- `team_staff` [Core]
- `rosters` [Core]
- `player_history` [Core]
- `nationalities` [Core]
- `regions` [Core]
- `affiliations` [Core]
- `club_hierarchies` [Core]

## 2. Competitions & Leagues
*Tables related to the structure of leagues, tournaments, and standings across the Benelux region.*

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

## 3. Live Scoring & In-Game Events
*Tables to support a comprehensive live scoring system and detailed in-game event tracking.*

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

## 4. Advanced Stats & Analytics
*Tables for granular statistics, advanced metrics, and tracking data.*

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

## 5. Operations, Licensing & Administration
*Tables handling the administrative side, including transfers, officials, and discipline.*

- `licenses` [Operations]
- `license_types` [Operations]
- `transfers` [Operations]
- `transfer_rules` [Operations]
- `suspensions` [Operations]
- `disciplinary_hearings` [Operations]
- `contracts` [Operations]
- `salaries` [Operations]
- `salary_caps` [Operations]
- `officials` [Operations]
- `referee_assignments` [Operations]
- `equipment_certifications` [Operations]
- `insurance_policies` [Operations]
- `background_checks` [Operations]

## 6. Regulatory & Compliance
*Tables for ensuring safety, integrity, and regulatory adherence.*

- `anti_doping_records` [Compliance]
- `safeguarding_logs` [Compliance]
- `safe_sport_certifications` [Compliance]
- `official_evaluations` [Compliance]
- `training_certifications` [Compliance]
- `incident_reports` [Compliance]
- `appeals` [Compliance]

## 7. Club Management & Logistics
*Tables for running a club on a day-to-day basis, from finances to travel.*

- `sponsors` [Management]
- `sponsorship_deals` [Management]
- `advertising_inventory` [Management]
- `club_finances` [Management]
- `invoices` [Management]
- `budgets` [Management]
- `expenses` [Management]
- `travel_itineraries` [Management]
- `transportation_logs` [Management]
- `accommodation_bookings` [Management]
- `volunteers` [Management]
- `volunteer_shifts` [Management]
- `staff_schedules` [Management]
- `youth_academies` [Management]
- `academy_enrollments` [Management]

## 8. Player Development, Scouting & Medical
*Tables for training, evaluation, scouting, and player health.*

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
- `draft_picks` [Development]
- `injuries` [Medical]
- `medical_records` [Medical]
- `rehab_programs` [Medical]
- `concussion_protocols` [Medical]
- `treatment_logs` [Medical]

## 9. Facilities & Maintenance
*Tables for arena operations and equipment.*

- `locker_rooms` [Facilities]
- `locker_assignments` [Facilities]
- `ice_maintenance_logs` [Facilities]
- `zamboni_schedules` [Facilities]
- `facility_bookings` [Facilities]
- `equipment_inventory` [Facilities]
- `equipment_repairs` [Facilities]
- `skate_sharpening_logs` [Facilities]
- `safety_inspections` [Facilities]

## 10. Social & Community
*Tables to support the social network features for fans, players, and clubs.*

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

## 11. Marketplace & Ticketing
*Tables for a marketplace supporting merchandise, ticket sales, and second-hand equipment.*

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

## 12. Gamification & Fantasy
*Tables for interactive features, fan engagement, and fantasy hockey.*

- `achievements` [Gamification]
- `badges` [Gamification]
- `user_achievements` [Gamification]
- `points_ledger` [Gamification]
- `leaderboards` [Gamification]
- `quests` [Gamification]
- `rewards` [Gamification]
- `fantasy_leagues` [Gamification]
- `fantasy_teams` [Gamification]
- `fantasy_drafts` [Gamification]
- `fantasy_rosters` [Gamification]
- `fantasy_matchups` [Gamification]
- `fantasy_scoring_rules` [Gamification]
- `fantasy_transactions` [Gamification]
- `predictions` [Gamification]
- `prediction_results` [Gamification]
- `trivia_questions` [Gamification]
- `trivia_answers` [Gamification]

## 13. Media, Broadcasting & Content
*Tables for news, broadcasting, and media storage.*

- `articles` [Media]
- `authors` [Media]
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
