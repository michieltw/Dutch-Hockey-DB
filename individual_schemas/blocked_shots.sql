-- 6. blocked_shots
CREATE TABLE blocked_shots (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BLKS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    blocking_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    shooting_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE blocked_shots ENABLE ROW LEVEL SECURITY;
