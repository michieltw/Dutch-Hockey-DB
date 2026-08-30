-- 2. club_hierarchies
CREATE TABLE club_hierarchies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLHI',
    parent_organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    child_organization_id UUID REFERENCES organizations(id) ON DELETE CASCADE,
    relationship_type VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE club_hierarchies ENABLE ROW LEVEL SECURITY;
