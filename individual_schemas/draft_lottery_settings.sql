-- draft_lottery_settings.sql
CREATE TABLE draft_lottery_settings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DLTS',
    draft_settings_id UUID NOT NULL REFERENCES draft_settings(id) ON DELETE CASCADE,
    lottery_type lottery_type_enum DEFAULT 'Weighted',
    number_of_lottery_winners INT DEFAULT 1,
    max_spots_moved_up INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_draft_lottery_settings_draft_settings_id ON draft_lottery_settings(draft_settings_id);

ALTER TABLE draft_lottery_settings ENABLE ROW LEVEL SECURITY;
