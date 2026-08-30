-- 17. tiebreakers
CREATE TABLE tiebreakers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TIEB',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    rule_description TEXT NOT NULL,
    priority_order INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE tiebreakers ENABLE ROW LEVEL SECURITY;
