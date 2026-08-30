-- 32. club_finances
CREATE TABLE club_finances (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CLFN',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    season_id UUID NOT NULL REFERENCES seasons(id) ON DELETE CASCADE,
    total_revenue NUMERIC(15, 2),
    total_expenses NUMERIC(15, 2),
    net_income NUMERIC(15, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE club_finances ENABLE ROW LEVEL SECURITY;
