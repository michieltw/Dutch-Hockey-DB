-- 5. shots
CREATE TABLE shots (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHOT',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE SET NULL,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    shooter_id UUID REFERENCES players(id) ON DELETE SET NULL,
    goalie_id UUID REFERENCES players(id) ON DELETE SET NULL,
    time_of_shot INTERVAL,
    shot_type shot_type_enum,
    is_goal BOOLEAN DEFAULT FALSE,
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    distance_to_net NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shots ENABLE ROW LEVEL SECURITY;
