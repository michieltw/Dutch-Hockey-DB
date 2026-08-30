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

-- Data for age_categories
INSERT INTO age_categories (id, name, min_age, max_age, description) VALUES
(gen_random_uuid(), 'U9', NULL, 8, 'Under 9 years old'),
(gen_random_uuid(), 'U11', 9, 10, 'Under 11 years old'),
(gen_random_uuid(), 'U13', 11, 12, 'Under 13 years old'),
(gen_random_uuid(), 'U15', 13, 14, 'Under 15 years old'),
(gen_random_uuid(), 'U17', 15, 16, 'Under 17 years old'),
(gen_random_uuid(), 'U21', 17, 20, 'Under 21 years old'),
(gen_random_uuid(), 'Senior', 21, NULL, 'Senior level');
