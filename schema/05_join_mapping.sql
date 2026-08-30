-- 05_join_mapping.sql
-- Mapping tables for many-to-many relationships and complex linkages

-- 1. external_links
CREATE TABLE external_links (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EXTL',
    entity_type VARCHAR(50) NOT NULL, -- e.g., 'player', 'club', 'league'
    entity_id UUID NOT NULL,          -- No specific FK here as it maps to multiple tables (Polymorphic)
    source_system VARCHAR(50) NOT NULL, -- e.g., 'IJNL', 'EliteProspects', 'HockeyDB'
    external_id VARCHAR(255) NOT NULL,
    url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE external_links ENABLE ROW LEVEL SECURITY;

-- 2. rosters
CREATE TABLE rosters (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ROST',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    jersey_number INTEGER,
    status roster_status_enum DEFAULT 'Active',
    joined_date DATE,
    left_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    UNIQUE(team_id, player_id, season_id)
);
ALTER TABLE rosters ENABLE ROW LEVEL SECURITY;

-- 3. team_staff
CREATE TABLE team_staff (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TMST',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    title VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE team_staff ENABLE ROW LEVEL SECURITY;

-- 4. player_agent_relationships
CREATE TABLE player_agent_relationships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLAG',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    agent_id UUID NOT NULL REFERENCES agents(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_agent_relationships ENABLE ROW LEVEL SECURITY;

-- 5. starting_lineups
CREATE TABLE starting_lineups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STLI',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    position position_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    UNIQUE(game_id, team_id, player_id)
);
ALTER TABLE starting_lineups ENABLE ROW LEVEL SECURITY;

-- 6. club_memberships (Social/Fans)
CREATE TABLE club_memberships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLMB',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    membership_type VARCHAR(50), -- e.g., 'Season Ticket Holder', 'Gold Member'
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE club_memberships ENABLE ROW LEVEL SECURITY;


-- 8. volunteer_assignments (Game Day Operations)
CREATE TABLE volunteer_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'VOLA',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    role VARCHAR(100), -- e.g., 'Tafeljury', 'Strafbank'
    status VARCHAR(50) DEFAULT 'Assigned',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE volunteer_assignments ENABLE ROW LEVEL SECURITY;

-- 9. player_achievements (Gamification linkage)
CREATE TABLE player_achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLACH',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    achievement_id UUID NOT NULL REFERENCES achievements(id) ON DELETE CASCADE,
    date_awarded TIMESTAMPTZ DEFAULT NOW(),
    season_id UUID REFERENCES seasons(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_achievements ENABLE ROW LEVEL SECURITY;

-- 10. game_officials (Linking officials to games)
CREATE TABLE game_officials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GMOF',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    official_id UUID NOT NULL REFERENCES officials(id) ON DELETE CASCADE,
    role VARCHAR(50), -- e.g., 'Referee', 'Linesman'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE game_officials ENABLE ROW LEVEL SECURITY;

-- 11. sponsorships (Linking sponsors to clubs/leagues)
CREATE TABLE sponsorships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SPSP',
    sponsor_id UUID NOT NULL REFERENCES sponsors(id) ON DELETE CASCADE,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    value NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sponsorships ENABLE ROW LEVEL SECURITY;

-- 12. player_sticks (Detailed equipment tracking)
CREATE TABLE player_sticks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STCK',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    year_purchased INTEGER,
    condition stick_condition_enum,
    flex INTEGER,
    curve VARCHAR(50),
    color VARCHAR(50),
    weight_grams INTEGER,
    length_inches NUMERIC(5, 2),
    composition VARCHAR(100),
    age_category_id UUID REFERENCES age_categories(id) ON DELETE SET NULL,
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_sticks ENABLE ROW LEVEL SECURITY;

-- 13. stick_performance_logs (Linked to player_sticks)
CREATE TABLE stick_performance_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STPL',
    stick_id UUID NOT NULL REFERENCES player_sticks(id) ON DELETE CASCADE,
    logged_date DATE NOT NULL,
    games_played_with INTEGER DEFAULT 0,
    practices_used INTEGER DEFAULT 0,
    estimated_performance_score NUMERIC(5, 2), -- 0.00 to 100.00
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE stick_performance_logs ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_rosters_team_id ON rosters(team_id);
CREATE INDEX idx_rosters_player_id ON rosters(player_id);
CREATE INDEX idx_rosters_season_id ON rosters(season_id);
CREATE INDEX idx_team_staff_team_id ON team_staff(team_id);
CREATE INDEX idx_team_staff_staff_id ON team_staff(staff_id);
CREATE INDEX idx_team_staff_season_id ON team_staff(season_id);
CREATE INDEX idx_player_agent_relationships_player_id ON player_agent_relationships(player_id);
CREATE INDEX idx_player_agent_relationships_agent_id ON player_agent_relationships(agent_id);
CREATE INDEX idx_starting_lineups_game_id ON starting_lineups(game_id);
CREATE INDEX idx_starting_lineups_team_id ON starting_lineups(team_id);
CREATE INDEX idx_starting_lineups_player_id ON starting_lineups(player_id);
CREATE INDEX idx_club_memberships_user_id ON club_memberships(user_id);
CREATE INDEX idx_club_memberships_club_id ON club_memberships(club_id);
CREATE INDEX idx_volunteer_assignments_person_id ON volunteer_assignments(person_id);
CREATE INDEX idx_volunteer_assignments_game_id ON volunteer_assignments(game_id);
CREATE INDEX idx_player_achievements_player_id ON player_achievements(player_id);
CREATE INDEX idx_player_achievements_achievement_id ON player_achievements(achievement_id);
CREATE INDEX idx_player_achievements_season_id ON player_achievements(season_id);
CREATE INDEX idx_game_officials_game_id ON game_officials(game_id);
CREATE INDEX idx_game_officials_official_id ON game_officials(official_id);
CREATE INDEX idx_sponsorships_sponsor_id ON sponsorships(sponsor_id);
CREATE INDEX idx_sponsorships_club_id ON sponsorships(club_id);
CREATE INDEX idx_sponsorships_league_id ON sponsorships(league_id);
CREATE INDEX idx_player_sticks_player_id ON player_sticks(player_id);
CREATE INDEX idx_player_sticks_brand_id ON player_sticks(brand_id);
CREATE INDEX idx_player_sticks_age_category_id ON player_sticks(age_category_id);
CREATE INDEX idx_stick_performance_logs_stick_id ON stick_performance_logs(stick_id);
