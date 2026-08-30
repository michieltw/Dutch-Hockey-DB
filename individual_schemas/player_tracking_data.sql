-- 25. player_tracking_data
CREATE TABLE player_tracking_data (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLTR',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    timestamp TIMESTAMPTZ NOT NULL,
    x_coordinate NUMERIC(8, 4),
    y_coordinate NUMERIC(8, 4),
    speed_kmh NUMERIC(5, 2),
    heart_rate INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_tracking_data ENABLE ROW LEVEL SECURITY;
