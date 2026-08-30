-- 9. safe_sport_certifications
CREATE TABLE safe_sport_certifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SSCT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    certification_name VARCHAR(255),
    completed_date DATE,
    expiry_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE safe_sport_certifications ENABLE ROW LEVEL SECURITY;
