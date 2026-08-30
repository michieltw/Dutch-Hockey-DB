-- 13. seating_charts
CREATE TABLE seating_charts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECH',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    layout_name VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seating_charts ENABLE ROW LEVEL SECURITY;
