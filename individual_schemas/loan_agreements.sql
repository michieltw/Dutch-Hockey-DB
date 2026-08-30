-- 25. loan_agreements
CREATE TABLE loan_agreements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LOAN',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    parent_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    loan_club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    start_date DATE,
    end_date DATE,
    recallable BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE loan_agreements ENABLE ROW LEVEL SECURITY;
