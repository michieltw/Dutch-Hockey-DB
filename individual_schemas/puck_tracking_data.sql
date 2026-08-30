-- 24. puck_tracking_data
CREATE TABLE puck_tracking_data (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PUCK',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    timestamp TIMESTAMPTZ NOT NULL,
    x_coordinate NUMERIC(8, 4),
    y_coordinate NUMERIC(8, 4),
    z_coordinate NUMERIC(8, 4),
    speed_kmh NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE puck_tracking_data ENABLE ROW LEVEL SECURITY;
