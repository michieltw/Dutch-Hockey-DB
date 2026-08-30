-- league_financial_settings.sql
CREATE TABLE league_financial_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LFNS',
    league_id UUID NOT NULL UNIQUE REFERENCES leagues(id) ON DELETE CASCADE,
    salary_cap_enabled BOOLEAN DEFAULT FALSE,
    salary_cap_hard_limit NUMERIC,
    salary_cap_floor NUMERIC,
    luxury_tax_enabled BOOLEAN DEFAULT FALSE,
    use_virtual_contracts BOOLEAN DEFAULT FALSE,
    max_contract_length_years INT,
    allow_retained_salary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_league_financial_settings_league_id ON league_financial_settings(league_id);

ALTER TABLE league_financial_settings ENABLE ROW LEVEL SECURITY;
