-- 12. sponsors
CREATE TABLE sponsors (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SPON',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    industry VARCHAR(100),
    sponsorship_level VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sponsors ENABLE ROW LEVEL SECURITY;
