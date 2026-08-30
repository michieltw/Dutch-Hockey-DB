-- 21. equipment_inventory
CREATE TABLE equipment_inventory (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQIN',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    item_name VARCHAR(100),
    quantity INTEGER,
    condition VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_inventory ENABLE ROW LEVEL SECURITY;
