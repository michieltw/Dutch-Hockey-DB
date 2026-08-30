-- 10. game_officials (Linking officials to games)
CREATE TABLE game_officials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GMOF',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    official_id UUID NOT NULL REFERENCES officials(id) ON DELETE CASCADE,
    role VARCHAR(50), -- e.g., 'Referee', 'Linesman'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE game_officials ENABLE ROW LEVEL SECURITY;
