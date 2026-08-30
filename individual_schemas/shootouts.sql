-- 13. shootouts
CREATE TABLE shootouts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHTO',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    round_number INTEGER,
    shooter_id UUID REFERENCES players(id) ON DELETE CASCADE,
    goalie_id UUID REFERENCES players(id) ON DELETE CASCADE,
    is_goal BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shootouts ENABLE ROW LEVEL SECURITY;
