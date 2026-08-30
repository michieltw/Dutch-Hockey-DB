-- 29. background_checks
CREATE TABLE background_checks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BGCK',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    check_date DATE,
    status VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE background_checks ENABLE ROW LEVEL SECURITY;
