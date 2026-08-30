-- 7. transfers
CREATE TABLE transfers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRAN',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    from_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    to_club_id UUID REFERENCES clubs(id) ON DELETE SET NULL,
    transfer_type transfer_type_enum,
    status transfer_status_enum DEFAULT 'Pending',
    transfer_date DATE,
    fee_amount NUMERIC(12, 2),
    currency VARCHAR(3) DEFAULT 'EUR',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE transfers ENABLE ROW LEVEL SECURITY;
