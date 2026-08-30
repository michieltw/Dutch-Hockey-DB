-- 26. player_protective_gear
CREATE TABLE player_protective_gear (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PPGR',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    gear_type VARCHAR(100), -- 'Helmet', 'Gloves', 'Pants'
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_protective_gear ENABLE ROW LEVEL SECURITY;
