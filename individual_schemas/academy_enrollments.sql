-- 39. academy_enrollments
CREATE TABLE academy_enrollments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACEN',
    academy_id UUID NOT NULL REFERENCES youth_academies(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    enrollment_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE academy_enrollments ENABLE ROW LEVEL SECURITY;
