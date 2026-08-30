-- 24. buyouts
CREATE TABLE buyouts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'BYOT',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    buyout_date DATE,
    total_cost NUMERIC(12, 2),
    cap_hit_penalty NUMERIC(12, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE buyouts ENABLE ROW LEVEL SECURITY;
