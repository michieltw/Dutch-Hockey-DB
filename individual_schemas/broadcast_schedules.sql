-- 43. broadcast_schedules
CREATE TABLE broadcast_schedules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BRSC',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    channel_name VARCHAR(100),
    start_time TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE broadcast_schedules ENABLE ROW LEVEL SECURITY;
