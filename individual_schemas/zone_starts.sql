-- 20. zone_starts
CREATE TABLE zone_starts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZSTA',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    offensive_zone_starts INTEGER DEFAULT 0,
    defensive_zone_starts INTEGER DEFAULT 0,
    neutral_zone_starts INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_starts ENABLE ROW LEVEL SECURITY;
