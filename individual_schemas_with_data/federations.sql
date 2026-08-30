-- 1. federations
CREATE TABLE federations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FEDE',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    region_id UUID REFERENCES regions(id) ON DELETE SET NULL,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE federations ENABLE ROW LEVEL SECURITY;

-- Data for federations
INSERT INTO federations (id, organization_id) VALUES
(gen_random_uuid(), 'f0000000-0000-0000-0000-000000000001'), -- IJshockey Nederland
(gen_random_uuid(), 'f0000000-0000-0000-0000-000000000002'), -- Royal Belgian Ice Hockey Federation
(gen_random_uuid(), 'f0000000-0000-0000-0000-000000000003'), -- FLHG
(gen_random_uuid(), 'f0000000-0000-0000-0000-000000000004'); -- IIHF
