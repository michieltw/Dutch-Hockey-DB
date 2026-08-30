-- 11. training_certifications
CREATE TABLE training_certifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRCT',
    coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
    certification_level VARCHAR(100),
    date_achieved DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE training_certifications ENABLE ROW LEVEL SECURITY;
