-- 16. licenses
CREATE TABLE licenses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICE',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    license_type_id UUID NOT NULL REFERENCES license_types(id) ON DELETE CASCADE,
    issue_date DATE,
    expiry_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE licenses ENABLE ROW LEVEL SECURITY;
