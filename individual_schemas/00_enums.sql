-- 01_enums_and_base.sql
-- Enums and Base Types for Benelux Ice Hockey Ecosystem

-- Player & Position Enums
CREATE TYPE position_enum AS ENUM ('Center', 'Left Wing', 'Right Wing', 'Defense', 'Goalie');
CREATE TYPE shoots_catches_enum AS ENUM ('L', 'R');
CREATE TYPE player_role_enum AS ENUM ('Sniper', 'Playmaker', 'Grinder', 'Two-Way', 'Enforcer', 'Offensive Defenseman', 'Defensive Defenseman', 'Butterfly', 'Stand-up', 'Hybrid');

-- Game & Event Enums
CREATE TYPE shot_type_enum AS ENUM ('Slap', 'Wrist', 'Snap', 'Backhand', 'Tip-in', 'Wrap-around', 'Deflection');
CREATE TYPE game_status_enum AS ENUM ('Scheduled', 'Warmup', 'In Progress', 'Intermission', 'Final', 'Final OT', 'Final SO', 'Postponed', 'Cancelled', 'Forfeit');
CREATE TYPE penalty_type_enum AS ENUM ('Minor', 'Bench Minor', 'Double Minor', 'Major', 'Misconduct', 'Game Misconduct', 'Match', 'Penalty Shot');
CREATE TYPE penalty_infraction_enum AS ENUM ('Tripping', 'Hooking', 'Slashing', 'Interference', 'High-sticking', 'Roughing', 'Cross-checking', 'Boarding', 'Charging', 'Delay of Game', 'Holding', 'Holding the Stick', 'Unsportsmanlike Conduct', 'Fighting', 'Spearing', 'Butt-ending', 'Clipping', 'Kneeing', 'Head-butting', 'Too Many Men');

-- Contract & Roster Enums
CREATE TYPE contract_type_enum AS ENUM ('Standard', 'Two-Way', 'Amateur', 'Tryout', 'Extension', 'Entry-Level');
CREATE TYPE contract_status_enum AS ENUM ('Active', 'Expired', 'Terminated', 'Bought Out', 'Suspended');
CREATE TYPE roster_status_enum AS ENUM ('Active', 'Injured Reserve', 'Scratched', 'Suspended', 'Loan', 'Minors');

-- Equipment Enums
CREATE TYPE stick_condition_enum AS ENUM ('New', 'Lightly Used', 'Used', 'Heavily Used', 'Broken');
CREATE TYPE age_category_enum AS ENUM ('Youth', 'Junior', 'Intermediate', 'Senior');
CREATE TYPE equipment_status_enum AS ENUM ('Currently Used', 'Previously Used', 'Backup', 'Wish List', 'Sold', 'Discarded');

-- Competition & Tournament Enums
CREATE TYPE league_tier_enum AS ENUM ('Professional', 'Semi-Pro', 'Amateur', 'Junior', 'Youth', 'Recreational');
CREATE TYPE series_format_enum AS ENUM ('Best of 1', 'Best of 3', 'Best of 5', 'Best of 7', 'Aggregate Score');

-- Injury Enums
CREATE TYPE injury_status_enum AS ENUM ('Active', 'Day-to-Day', 'Week-to-Week', 'Month-to-Month', 'Out for Season', 'Recovered');
CREATE TYPE injury_type_enum AS ENUM ('Upper Body', 'Lower Body', 'Head/Concussion', 'Illness', 'Undisclosed');

-- User & Platform Enums
CREATE TYPE user_role_enum AS ENUM ('Admin', 'Federation Official', 'Club Manager', 'Coach', 'Player', 'Fan', 'Referee', 'Scorekeeper');
CREATE TYPE organization_type_enum AS ENUM ('Federation', 'Club', 'Sponsor', 'Agency', 'Media', 'Vendor');
CREATE TYPE transfer_type_enum AS ENUM ('Permanent', 'Loan', 'Tryout', 'Rights Only');
CREATE TYPE transfer_status_enum AS ENUM ('Pending', 'Approved', 'Rejected', 'Cancelled', 'Completed');

-- Order & E-commerce Enums
CREATE TYPE order_status_enum AS ENUM ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled', 'Refunded');
CREATE TYPE payment_status_enum AS ENUM ('Pending', 'Paid', 'Failed', 'Refunded');

-- Ticket Enums
CREATE TYPE ticket_status_enum AS ENUM ('Available', 'Reserved', 'Sold', 'Scanned', 'Cancelled');

-- Content & Social Enums
CREATE TYPE media_type_enum AS ENUM ('Image', 'Video', 'Document', 'Audio');
CREATE TYPE post_status_enum AS ENUM ('Draft', 'Published', 'Archived', 'Deleted');
