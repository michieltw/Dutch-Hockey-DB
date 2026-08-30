-- 25. digital_game_sheets
CREATE TABLE digital_game_sheets (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DWFS',
    game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
    submitted_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
    submitted_at TIMESTAMPTZ,
    pdf_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE digital_game_sheets ENABLE ROW LEVEL SECURITY;
