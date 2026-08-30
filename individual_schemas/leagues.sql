-- 5. leagues
CREATE TABLE leagues (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LEAG',
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    region_id UUID REFERENCES regions(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    tier league_tier_enum,
    level_of_play VARCHAR(100),
    is_professional BOOLEAN DEFAULT FALSE,
    gender VARCHAR(20),
    age_category_id UUID REFERENCES age_categories(id) ON DELETE SET NULL,
    logo_url TEXT,
    founded_year INTEGER,
    website VARCHAR(255),
    social_twitter VARCHAR(255),
    social_instagram VARCHAR(255),
    social_facebook VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_leagues_federation_id ON leagues(federation_id);
CREATE INDEX idx_leagues_region_id ON leagues(region_id);
CREATE INDEX idx_leagues_age_category_id ON leagues(age_category_id);

ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
