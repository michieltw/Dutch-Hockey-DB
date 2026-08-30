-- 12. draft_picks
CREATE TABLE draft_picks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRPK',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    draft_year INTEGER,
    round_number INTEGER,
    pick_number INTEGER,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE draft_picks ENABLE ROW LEVEL SECURITY;
