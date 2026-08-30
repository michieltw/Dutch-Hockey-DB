-- 1. federation_memberships
CREATE TABLE federation_memberships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FDMB',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    federation_id UUID NOT NULL REFERENCES federations(id) ON DELETE CASCADE,
    membership_number VARCHAR(100), -- Bondsnummer
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE federation_memberships ENABLE ROW LEVEL SECURITY;
