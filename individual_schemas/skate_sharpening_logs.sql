-- 23. skate_sharpening_logs
CREATE TABLE skate_sharpening_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SKSL',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    hollow_radius VARCHAR(50),
    sharpened_by_id UUID REFERENCES staff(id) ON DELETE SET NULL,
    date_sharpened DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE skate_sharpening_logs ENABLE ROW LEVEL SECURITY;
