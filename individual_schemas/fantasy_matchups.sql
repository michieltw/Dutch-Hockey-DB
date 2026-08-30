-- 25. fantasy_matchups
CREATE TABLE fantasy_matchups (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FMAT',
    league_id UUID NOT NULL REFERENCES fantasy_leagues(id) ON DELETE CASCADE,
    team1_id UUID NOT NULL REFERENCES fantasy_teams(id) ON DELETE CASCADE,
    team2_id UUID NOT NULL REFERENCES fantasy_teams(id) ON DELETE CASCADE,
    week_number INTEGER,
    team1_score NUMERIC(5, 2) DEFAULT 0,
    team2_score NUMERIC(5, 2) DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fantasy_matchups ENABLE ROW LEVEL SECURITY;
