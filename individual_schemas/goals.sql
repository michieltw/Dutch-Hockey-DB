-- 3. goals
CREATE TABLE goals (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GOAL',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    period_id UUID REFERENCES periods(id) ON DELETE SET NULL,
    scoring_team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    scorer_id UUID REFERENCES players(id) ON DELETE SET NULL,
    primary_assist_id UUID REFERENCES players(id) ON DELETE SET NULL,
    secondary_assist_id UUID REFERENCES players(id) ON DELETE SET NULL,
    time_of_goal INTERVAL,
    shot_type shot_type_enum,
    distance_to_net NUMERIC(5, 2),
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    is_powerplay BOOLEAN DEFAULT FALSE,
    is_shorthanded BOOLEAN DEFAULT FALSE,
    is_empty_net BOOLEAN DEFAULT FALSE,
    is_penalty_shot BOOLEAN DEFAULT FALSE,
    is_game_winning BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
