-- 21. retained_salaries
CREATE TABLE retained_salaries (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'RETS',
    contract_id UUID NOT NULL REFERENCES contracts(id) ON DELETE CASCADE,
    retaining_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    retained_percentage NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE retained_salaries ENABLE ROW LEVEL SECURITY;
