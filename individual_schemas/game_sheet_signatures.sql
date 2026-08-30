-- 26. game_sheet_signatures
CREATE TABLE game_sheet_signatures (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'GSIG',
    game_sheet_id UUID NOT NULL REFERENCES digital_game_sheets(id) ON DELETE CASCADE,
    signer_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50), -- 'Home Coach', 'Away Coach', 'Referee'
    signed_at TIMESTAMPTZ DEFAULT NOW(),
    signature_data TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE game_sheet_signatures ENABLE ROW LEVEL SECURITY;
