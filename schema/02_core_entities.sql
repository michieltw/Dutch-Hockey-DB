-- 02_core_entities.sql
-- Foundational Tables for Benelux Ice Hockey Ecosystem (No complex dependencies)

-- 1. persons (Core human record)
CREATE TABLE persons (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PERS',
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender VARCHAR(20),
    email VARCHAR(255),
    phone_number VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    profile_picture_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE persons ENABLE ROW LEVEL SECURITY;

-- 2. organizations (Core entity record)
CREATE TABLE organizations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ORGA',
    organization_type organization_type_enum NOT NULL,
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    founded_year INTEGER,
    website_url TEXT,
    logo_url TEXT,
    contact_email VARCHAR(255),
    contact_phone VARCHAR(50),
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE organizations ENABLE ROW LEVEL SECURITY;

-- 3. nationalities
CREATE TABLE nationalities (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NATI',
    name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(3) NOT NULL,
    flag_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE nationalities ENABLE ROW LEVEL SECURITY;

-- 4. regions
CREATE TABLE regions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REGI',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE regions ENABLE ROW LEVEL SECURITY;

-- 5. seasons
CREATE TABLE seasons (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SEAS',
    name VARCHAR(50) NOT NULL, -- e.g. "2023-2024"
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seasons ENABLE ROW LEVEL SECURITY;

-- 6. rulebooks
CREATE TABLE rulebooks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RULE',
    name VARCHAR(255) NOT NULL, -- e.g. "IIHF Official Rule Book"
    publisher VARCHAR(255),
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rulebooks ENABLE ROW LEVEL SECURITY;

-- 7. license_types
CREATE TABLE license_types (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LICT',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    requires_medical_clearance BOOLEAN DEFAULT FALSE,
    requires_background_check BOOLEAN DEFAULT FALSE,
    duration_months INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE license_types ENABLE ROW LEVEL SECURITY;

-- 8. categories (for Marketplace)
CREATE TABLE categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CATG',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- 9. brands (for Marketplace and Equipment)
CREATE TABLE brands (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BRND',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    logo_url TEXT,
    website_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE brands ENABLE ROW LEVEL SECURITY;

-- 10. age_categories
CREATE TABLE age_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGEC',
    name VARCHAR(50) NOT NULL, -- e.g. "U18", "U20", "Senior"
    min_age INTEGER,
    max_age INTEGER,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE age_categories ENABLE ROW LEVEL SECURITY;

-- 11. tags (for Media)
CREATE TABLE tags (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TAGS',
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;

-- 12. awards
CREATE TABLE awards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AWRD',
    name VARCHAR(255) NOT NULL,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE awards ENABLE ROW LEVEL SECURITY;

-- 13. achievements (Gamification)
CREATE TABLE achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACHV',
    name VARCHAR(255) NOT NULL,
    description TEXT,
    points_awarded INTEGER DEFAULT 0,
    icon_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;

-- 14. badges (Gamification)
CREATE TABLE badges (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BADG',
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE badges ENABLE ROW LEVEL SECURITY;
