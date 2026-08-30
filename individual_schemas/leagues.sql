-- 5. leagues
CREATE TABLE leagues (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LEAG',
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    tier league_tier_enum,
    gender VARCHAR(20),
    age_category_id UUID REFERENCES age_categories(id) ON DELETE SET NULL,
    logo_url TEXT,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
