-- 20. salaries
CREATE TABLE salaries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SALA',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    base_amount NUMERIC(12, 2),
    bonus_amount NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE salaries ENABLE ROW LEVEL SECURITY;
