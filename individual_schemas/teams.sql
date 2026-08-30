-- 6. teams
CREATE TABLE teams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TEAM',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL, -- e.g., "GIJS Groningen U18"
    abbreviation VARCHAR(50),
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    home_arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    head_coach_id UUID, -- Will reference coaches table
    captain_id UUID, -- Will reference players table
    logo_url TEXT,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
