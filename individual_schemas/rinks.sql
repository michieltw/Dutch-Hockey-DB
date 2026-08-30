-- 3. rinks (An arena can have multiple rinks)
CREATE TABLE rinks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RINK',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    length_meters NUMERIC(5, 2),
    width_meters NUMERIC(5, 2),
    ice_type VARCHAR(50),
    is_indoor BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rinks ENABLE ROW LEVEL SECURITY;
