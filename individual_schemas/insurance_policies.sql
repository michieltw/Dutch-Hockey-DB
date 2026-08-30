-- 28. insurance_policies
CREATE TABLE insurance_policies (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INSP',
    club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    provider_name VARCHAR(255),
    policy_number VARCHAR(100),
    coverage_amount NUMERIC(15, 2),
    expiry_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE insurance_policies ENABLE ROW LEVEL SECURITY;
