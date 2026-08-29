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

## 3. Live Scoring & Events
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
- `goaltender_stats` [Live Scoring]
- `player_game_stats` [Live Scoring]
- `team_game_stats` [Live Scoring]
- `time_outs` [Live Scoring]
- `shootouts` [Live Scoring]
- `video_reviews` [Live Scoring]

## 4. Operations, Licensing & Administration
*Tables handling the administrative side, including transfers, officials, and discipline.*

- `licenses` [Operations]
- `license_types` [Operations]
- `transfers` [Operations]
- `transfer_rules` [Operations]
- `suspensions` [Operations]
- `injuries` [Operations]
- `medical_records` [Operations]
- `contracts` [Operations]
- `salaries` [Operations]
- `officials` [Operations]
- `referee_assignments` [Operations]
- `equipment_certifications` [Operations]
- `insurance_policies` [Operations]

## 5. Social & Community
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

## 6. Marketplace
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
- `tickets` [Marketplace]
- `season_tickets` [Marketplace]
- `ticket_scans` [Marketplace]
- `classified_ads` [Marketplace]
- `bids` [Marketplace]

## 7. Gamification & Fantasy
*Tables for interactive features, fan engagement, and fantasy hockey.*

- `achievements` [Gamification]
- `badges` [Gamification]
- `user_achievements` [Gamification]
- `points_ledger` [Gamification]
- `leaderboards` [Gamification]
- `fantasy_leagues` [Gamification]
- `fantasy_teams` [Gamification]
- `fantasy_drafts` [Gamification]
- `fantasy_rosters` [Gamification]
- `fantasy_matchups` [Gamification]
- `fantasy_scoring_rules` [Gamification]
- `predictions` [Gamification]
- `prediction_results` [Gamification]
- `trivia_questions` [Gamification]
- `trivia_answers` [Gamification]

## 8. Media & Content
*Tables for news, broadcasting, and media storage.*

- `articles` [Media]
- `galleries` [Media]
- `photos` [Media]
- `videos` [Media]
- `live_streams` [Media]
- `highlights` [Media]
- `tags` [Media]
