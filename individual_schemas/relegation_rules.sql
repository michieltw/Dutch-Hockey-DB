-- 18. relegation_rules
CREATE TABLE relegation_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'REGR',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    description TEXT,
    spots_relegated INTEGER,
    spots_promoted INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE relegation_rules ENABLE ROW LEVEL SECURITY;
