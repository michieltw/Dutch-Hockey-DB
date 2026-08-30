-- 13. achievements (Gamification)
CREATE TABLE achievements (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ACHV',
    name VARCHAR(255) NOT NULL,
    description TEXT,
    points_awarded INTEGER DEFAULT 0,
    icon_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;
