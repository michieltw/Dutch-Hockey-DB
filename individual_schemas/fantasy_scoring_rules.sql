-- 26. fantasy_scoring_rules
CREATE TABLE fantasy_scoring_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FSCR',
    league_id UUID NOT NULL REFERENCES fantasy_leagues(id) ON DELETE CASCADE,
    action VARCHAR(50), -- 'Goal', 'Assist'
    points_awarded NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fantasy_scoring_rules ENABLE ROW LEVEL SECURITY;
