-- 12. player_sticks (Detailed equipment tracking)
CREATE TABLE player_sticks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STCK',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    model VARCHAR(100),
    year_purchased INTEGER,
    condition stick_condition_enum,
    flex INTEGER,
    curve VARCHAR(50),
    color VARCHAR(50),
    weight_grams INTEGER,
    length_inches NUMERIC(5, 2),
    composition VARCHAR(100),
    age_category_id UUID REFERENCES age_categories(id) ON DELETE SET NULL,
    status equipment_status_enum,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE player_sticks ENABLE ROW LEVEL SECURITY;
