-- 8. national_team_selections
CREATE TABLE national_team_selections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NTSE',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    nationality_id UUID NOT NULL REFERENCES nationalities(id) ON DELETE CASCADE,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE SET NULL,
    year INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE national_team_selections ENABLE ROW LEVEL SECURITY;
