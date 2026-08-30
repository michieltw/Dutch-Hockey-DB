-- player_rights
CREATE TABLE player_rights (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLRT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    rights_type VARCHAR(50), -- e.g., 'Draft', 'KHL', 'CHL', 'NHL'
    acquired_date DATE,
    expires_date DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ,
    CHECK (club_id IS NOT NULL OR league_id IS NOT NULL)
);
ALTER TABLE player_rights ENABLE ROW LEVEL SECURITY;
