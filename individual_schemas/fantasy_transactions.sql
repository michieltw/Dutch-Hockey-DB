-- 27. fantasy_transactions
CREATE TABLE fantasy_transactions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FTRA',
    team_id UUID NOT NULL REFERENCES fantasy_teams(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    transaction_type VARCHAR(50), -- 'Add', 'Drop', 'Trade'
    transaction_date TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fantasy_transactions ENABLE ROW LEVEL SECURITY;
