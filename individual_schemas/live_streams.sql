-- 42. live_streams
CREATE TABLE live_streams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LSTR',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    stream_url TEXT NOT NULL,
    platform VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE live_streams ENABLE ROW LEVEL SECURITY;
