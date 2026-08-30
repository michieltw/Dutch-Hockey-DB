-- 26. two_way_contracts
CREATE TABLE two_way_contracts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TWOC',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    major_league_salary NUMERIC(12, 2),
    minor_league_salary NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE two_way_contracts ENABLE ROW LEVEL SECURITY;
