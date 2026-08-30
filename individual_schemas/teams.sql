-- 6. teams
CREATE TABLE teams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TEAM',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL, -- e.g., "GIJS Groningen U18"
    abbreviation VARCHAR(50),
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    home_arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    region_id UUID REFERENCES regions(id) ON DELETE SET NULL,
    head_coach_id UUID, -- Will reference coaches table
    captain_id UUID, -- Will reference players table
    logo_url TEXT,
    founded_year INTEGER,
    website VARCHAR(255),
    social_twitter VARCHAR(255),
    social_instagram VARCHAR(255),
    social_facebook VARCHAR(255),
    home_ice_advantage_metric NUMERIC,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_teams_club_id ON teams(club_id);
CREATE INDEX idx_teams_league_id ON teams(league_id);
CREATE INDEX idx_teams_home_arena_id ON teams(home_arena_id);
CREATE INDEX idx_teams_region_id ON teams(region_id);
CREATE INDEX idx_teams_head_coach_id ON teams(head_coach_id);
CREATE INDEX idx_teams_captain_id ON teams(captain_id);

ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
