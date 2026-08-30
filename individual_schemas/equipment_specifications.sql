-- 6. equipment_specifications
CREATE TABLE equipment_specifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EQSP',
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    visor_mandatory BOOLEAN DEFAULT FALSE,
    neck_guard_mandatory BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE equipment_specifications ENABLE ROW LEVEL SECURITY;
