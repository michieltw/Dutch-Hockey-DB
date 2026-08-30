-- 10. age_categories
CREATE TABLE age_categories (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'AGEC',
    name VARCHAR(50) NOT NULL, -- e.g. "U18", "U20", "Senior"
    min_age INTEGER,
    max_age INTEGER,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE age_categories ENABLE ROW LEVEL SECURITY;
