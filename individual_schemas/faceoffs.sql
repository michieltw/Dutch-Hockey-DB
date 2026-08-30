-- 4. faceoffs
CREATE TABLE faceoffs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FACE',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE CASCADE,
    winning_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    losing_player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    zone VARCHAR(20), -- 'Offensive', 'Defensive', 'Neutral'
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    time_elapsed INTERVAL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE faceoffs ENABLE ROW LEVEL SECURITY;
