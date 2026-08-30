-- 29. skating_speed_records
CREATE TABLE skating_speed_records (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKSP',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    top_speed_kmh NUMERIC(5, 2),
    bursts_over_30kmh INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skating_speed_records ENABLE ROW LEVEL SECURITY;
