-- 6. contracts
CREATE TABLE contracts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CONT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    contract_type contract_type_enum,
    status contract_status_enum DEFAULT 'Active',
    start_date DATE,
    end_date DATE,
    signing_date DATE,
    base_salary NUMERIC(12, 2),
    signing_bonus NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    cap_hit NUMERIC(12, 2),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE contracts ENABLE ROW LEVEL SECURITY;
