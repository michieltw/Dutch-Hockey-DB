-- 8. volunteer_assignments (Game Day Operations)
CREATE TABLE volunteer_assignments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'VOLA',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    role VARCHAR(100), -- e.g., 'Tafeljury', 'Strafbank'
    status VARCHAR(50) DEFAULT 'Assigned',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE volunteer_assignments ENABLE ROW LEVEL SECURITY;
