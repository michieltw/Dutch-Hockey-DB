-- 19. leaderboards
CREATE TABLE leaderboards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'LDBO',
    name VARCHAR(100),
    type VARCHAR(50), -- 'Global', 'Club Specific'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE leaderboards ENABLE ROW LEVEL SECURITY;
