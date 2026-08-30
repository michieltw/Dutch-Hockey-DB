-- transfer_window_settings.sql
CREATE TABLE transfer_window_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRWS',
    league_id UUID NOT NULL REFERENCES leagues(id) ON DELETE CASCADE,
    window_type transfer_window_type_enum NOT NULL,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    trade_deadline TIMESTAMPTZ,
    allow_loans BOOLEAN DEFAULT TRUE,
    allow_international_transfers BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_transfer_window_settings_league_id ON transfer_window_settings(league_id);

ALTER TABLE transfer_window_settings ENABLE ROW LEVEL SECURITY;
