-- 4. international_transfer_cards
CREATE TABLE international_transfer_cards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ITCS',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    from_federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    to_federation_id UUID REFERENCES federations(id) ON DELETE SET NULL,
    issue_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE international_transfer_cards ENABLE ROW LEVEL SECURITY;
