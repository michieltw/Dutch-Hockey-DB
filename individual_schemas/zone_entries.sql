-- 21. zone_entries
CREATE TABLE zone_entries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ZENT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    carried_in INTEGER DEFAULT 0,
    dumped_in INTEGER DEFAULT 0,
    passed_in INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE zone_entries ENABLE ROW LEVEL SECURITY;
