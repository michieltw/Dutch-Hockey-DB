-- 22. equipment_repairs
CREATE TABLE equipment_repairs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQRE',
    inventory_id UUID NOT NULL REFERENCES equipment_inventory(id) ON DELETE CASCADE,
    repair_date DATE,
    cost NUMERIC(10, 2),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_repairs ENABLE ROW LEVEL SECURITY;
