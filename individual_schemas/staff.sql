-- 9. staff
CREATE TABLE staff (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STFF',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    role VARCHAR(100), -- e.g., General Manager, Equipment Manager
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff ENABLE ROW LEVEL SECURITY;
