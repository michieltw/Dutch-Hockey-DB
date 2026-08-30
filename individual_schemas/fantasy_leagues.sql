-- 22. fantasy_leagues
CREATE TABLE fantasy_leagues (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FLEA',
    name VARCHAR(100),
    creator_id UUID REFERENCES users(id) ON DELETE SET NULL,
    season_id UUID REFERENCES seasons(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fantasy_leagues ENABLE ROW LEVEL SECURITY;
