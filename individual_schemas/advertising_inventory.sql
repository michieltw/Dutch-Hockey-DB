-- 31. advertising_inventory
CREATE TABLE advertising_inventory (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ADIN',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    location VARCHAR(100), -- 'Boards', 'Ice', 'Zamboni'
    price NUMERIC(10, 2),
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE advertising_inventory ENABLE ROW LEVEL SECURITY;
