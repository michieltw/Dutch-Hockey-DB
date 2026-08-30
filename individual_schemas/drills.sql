-- 3. drills
CREATE TABLE drills (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRIL',
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50), -- 'Skating', 'Shooting', 'Passing'
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE drills ENABLE ROW LEVEL SECURITY;
