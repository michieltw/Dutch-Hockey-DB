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
