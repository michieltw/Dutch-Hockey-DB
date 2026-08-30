-- 15. goaltender_stats
CREATE TABLE goaltender_stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GSTA',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    shots_against INTEGER DEFAULT 0,
    saves INTEGER DEFAULT 0,
    goals_against INTEGER DEFAULT 0,
    time_on_ice INTERVAL,
    is_win BOOLEAN DEFAULT FALSE,
    is_loss BOOLEAN DEFAULT FALSE,
    is_otl BOOLEAN DEFAULT FALSE,
    is_shutout BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE goaltender_stats ENABLE ROW LEVEL SECURITY;
