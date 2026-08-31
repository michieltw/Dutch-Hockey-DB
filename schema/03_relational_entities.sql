-- 03_relational_entities.sql
-- Tables depending on core entities (Clubs, Players, Teams, Leagues, etc.)

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

-- 2. arenas
CREATE TABLE arenas (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AREN',
    name VARCHAR(255) NOT NULL,
    abbreviation VARCHAR(50),
    capacity INTEGER,
    year_built INTEGER,
    address_line1 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    latitude NUMERIC(10, 8),
    longitude NUMERIC(11, 8),
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE arenas ENABLE ROW LEVEL SECURITY;

-- 3. rinks (An arena can have multiple rinks)
CREATE TABLE rinks (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RINK',
    arena_id UUID NOT NULL REFERENCES arenas(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    length_meters NUMERIC(5, 2),
    width_meters NUMERIC(5, 2),
    ice_type VARCHAR(50),
    is_indoor BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE rinks ENABLE ROW LEVEL SECURITY;

-- 4. clubs
CREATE TABLE clubs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLUB',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    home_arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    primary_color VARCHAR(20),
    secondary_color VARCHAR(20),
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE clubs ENABLE ROW LEVEL SECURITY;

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

-- 6. teams
CREATE TABLE teams (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TEAM',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL, -- e.g., "GIJS Groningen U18"
    abbreviation VARCHAR(50),
    league_id UUID REFERENCES leagues(id) ON DELETE SET NULL,
    home_arena_id UUID REFERENCES arenas(id) ON DELETE SET NULL,
    head_coach_id UUID, -- Will reference coaches table
    captain_id UUID, -- Will reference players table
    logo_url TEXT,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;

-- 7. players
CREATE TABLE players (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PLYR',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    nationality_id UUID REFERENCES nationalities(id) ON DELETE SET NULL,
    height_cm INTEGER,
    weight_kg INTEGER,
    shoots shoots_catches_enum,
    primary_position position_enum,
    player_role player_role_enum,
    birth_city VARCHAR(100),
    birth_country VARCHAR(100),
    draft_year INTEGER,
    draft_overall_pick INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    elite_prospects_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE players ENABLE ROW LEVEL SECURITY;

-- Add foreign key constraint to teams for captain_id now that players is created
ALTER TABLE teams ADD CONSTRAINT fk_teams_captain FOREIGN KEY (captain_id) REFERENCES players(id) ON DELETE SET NULL;

-- 8. coaches
CREATE TABLE coaches (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'COCH',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    coaching_level VARCHAR(50),
    years_experience INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE coaches ENABLE ROW LEVEL SECURITY;

-- Add foreign key constraint to teams for head_coach_id now that coaches is created
ALTER TABLE teams ADD CONSTRAINT fk_teams_head_coach FOREIGN KEY (head_coach_id) REFERENCES coaches(id) ON DELETE SET NULL;

-- 9. staff
CREATE TABLE staff (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STFF',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    role VARCHAR(100), -- e.g., General Manager, Equipment Manager
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff ENABLE ROW LEVEL SECURITY;

-- 10. users
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'USER',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    username VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    primary_role user_role_enum,
    is_verified BOOLEAN DEFAULT FALSE,
    last_login TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 11. products (Marketplace)
CREATE TABLE products (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PROD',
    category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
    brand_id UUID REFERENCES brands(id) ON DELETE SET NULL,
    organization_id UUID REFERENCES organizations(id) ON DELETE SET NULL, -- Allow any org to have products
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'EUR',
    sku VARCHAR(100),
    stock_quantity INTEGER DEFAULT 0,
    image_url TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

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

-- 13. officials (Referees, Linesmen)
CREATE TABLE officials (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'OFFI',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    certification_level VARCHAR(50),
    years_experience INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    ijnl_id VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE officials ENABLE ROW LEVEL SECURITY;

-- 14. agents
CREATE TABLE agents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGNT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    certification_number VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE agents ENABLE ROW LEVEL SECURITY;

-- 15. agencies
CREATE TABLE agencies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGCY',
    organization_id UUID NOT NULL REFERENCES organizations(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE agencies ENABLE ROW LEVEL SECURITY;

-- 16. youth_academies
CREATE TABLE youth_academies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACAD',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    director_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE youth_academies ENABLE ROW LEVEL SECURITY;

-- 17. divisions
CREATE TABLE divisions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DIVI',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE divisions ENABLE ROW LEVEL SECURITY;

-- 18. conferences
CREATE TABLE conferences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CONF',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE conferences ENABLE ROW LEVEL SECURITY;

-- 19. tournaments
CREATE TABLE tournaments (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TOKN',
    name VARCHAR(255) NOT NULL,
    host_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    start_date DATE,
    end_date DATE,
    logo_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;

-- Indexes for foreign keys
CREATE INDEX idx_federations_organization_id ON federations(organization_id);
CREATE INDEX idx_federations_region_id ON federations(region_id);
CREATE INDEX idx_rinks_arena_id ON rinks(arena_id);
CREATE INDEX idx_clubs_organization_id ON clubs(organization_id);
CREATE INDEX idx_clubs_federation_id ON clubs(federation_id);
CREATE INDEX idx_clubs_home_arena_id ON clubs(home_arena_id);
CREATE INDEX idx_leagues_federation_id ON leagues(federation_id);
CREATE INDEX idx_leagues_age_category_id ON leagues(age_category_id);
CREATE INDEX idx_teams_club_id ON teams(club_id);
CREATE INDEX idx_teams_league_id ON teams(league_id);
CREATE INDEX idx_teams_home_arena_id ON teams(home_arena_id);
CREATE INDEX idx_players_person_id ON players(person_id);
CREATE INDEX idx_players_nationality_id ON players(nationality_id);
CREATE INDEX idx_coaches_person_id ON coaches(person_id);
CREATE INDEX idx_staff_person_id ON staff(person_id);
CREATE INDEX idx_users_person_id ON users(person_id);
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_products_brand_id ON products(brand_id);
CREATE INDEX idx_products_club_id ON products(club_id);
CREATE INDEX idx_sponsors_organization_id ON sponsors(organization_id);
CREATE INDEX idx_officials_person_id ON officials(person_id);
CREATE INDEX idx_officials_federation_id ON officials(federation_id);
CREATE INDEX idx_agents_person_id ON agents(person_id);
CREATE INDEX idx_agencies_organization_id ON agencies(organization_id);
CREATE INDEX idx_youth_academies_club_id ON youth_academies(club_id);
CREATE INDEX idx_youth_academies_director_id ON youth_academies(director_id);
CREATE INDEX idx_divisions_league_id ON divisions(league_id);
CREATE INDEX idx_conferences_league_id ON conferences(league_id);
CREATE INDEX idx_tournaments_host_club_id ON tournaments(host_club_id);
CREATE INDEX idx_teams_captain_id ON teams(captain_id);
CREATE INDEX idx_teams_head_coach_id ON teams(head_coach_id);
