-- 22. zone_exits
CREATE TABLE zone_exits (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZEXT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    carried_out INTEGER DEFAULT 0,
    passed_out INTEGER DEFAULT 0,
    failed_exits INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_exits ENABLE ROW LEVEL SECURITY;
