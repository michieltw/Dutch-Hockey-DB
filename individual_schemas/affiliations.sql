-- 1. affiliations
CREATE TABLE affiliations (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AFFL',
    parent_club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    farm_club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE affiliations ENABLE ROW LEVEL SECURITY;
