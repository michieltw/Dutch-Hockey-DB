-- 11. sponsorships (Linking sponsors to clubs/leagues)
CREATE TABLE sponsorships (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SPSP',
    sponsor_id UUID NOT NULL REFERENCES sponsors(id) ON DELETE CASCADE,
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    league_id UUID REFERENCES leagues(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    value NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sponsorships ENABLE ROW LEVEL SECURITY;
