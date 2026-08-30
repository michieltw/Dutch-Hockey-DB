-- 23. shot_locations
CREATE TABLE shot_locations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SHLO',
    shot_id UUID NOT NULL REFERENCES shots(id) ON DELETE CASCADE,
    zone VARCHAR(50), -- 'High Slot', 'Point', 'Crease'
    x_coordinate NUMERIC(5, 2),
    y_coordinate NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE shot_locations ENABLE ROW LEVEL SECURITY;
