-- 17. team_game_stats
CREATE TABLE team_game_stats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TGST',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    shots INTEGER DEFAULT 0,
    powerplay_opportunities INTEGER DEFAULT 0,
    powerplay_goals INTEGER DEFAULT 0,
    penalty_minutes INTEGER DEFAULT 0,
    faceoffs_won INTEGER DEFAULT 0,
    giveaways INTEGER DEFAULT 0,
    takeaways INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE team_game_stats ENABLE ROW LEVEL SECURITY;
