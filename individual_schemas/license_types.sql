-- 7. license_types
CREATE TABLE license_types (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICT',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    requires_background_check BOOLEAN DEFAULT FALSE,
    duration_months INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE license_types ENABLE ROW LEVEL SECURITY;
