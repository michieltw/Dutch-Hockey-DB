-- 25. player_skates
CREATE TABLE player_skates (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PSKA',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    size NUMERIC(4, 1),
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_skates ENABLE ROW LEVEL SECURITY;
