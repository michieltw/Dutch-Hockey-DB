-- 24. safety_inspections
CREATE TABLE safety_inspections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SAFI',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    inspection_date DATE,
    inspector_name VARCHAR(100),
    passed BOOLEAN,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safety_inspections ENABLE ROW LEVEL SECURITY;
