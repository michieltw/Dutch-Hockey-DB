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
