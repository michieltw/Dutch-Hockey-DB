-- 17. transfer_rules
CREATE TABLE transfer_rules (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRRU',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    deadline DATE,
    max_transfers_per_season INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfer_rules ENABLE ROW LEVEL SECURITY;
