-- 5. rink_specifications
CREATE TABLE rink_specifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RNKS',
    rink_id UUID NOT NULL REFERENCES rinks(id) ON DELETE CASCADE,
    glass_height_cm INTEGER,
    boards_height_cm INTEGER,
    ice_temperature NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rink_specifications ENABLE ROW LEVEL SECURITY;
