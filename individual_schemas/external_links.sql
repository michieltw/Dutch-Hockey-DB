-- 1. external_links
CREATE TABLE external_links (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'EXTL',
    entity_type VARCHAR(50) NOT NULL, -- e.g., 'player', 'club', 'league'
    entity_id UUID NOT NULL,          -- No specific FK here as it maps to multiple tables (Polymorphic)
    source_system VARCHAR(50) NOT NULL, -- e.g., 'IJNL', 'EliteProspects', 'HockeyDB'
    external_id VARCHAR(255) NOT NULL,
    url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE external_links ENABLE ROW LEVEL SECURITY;
