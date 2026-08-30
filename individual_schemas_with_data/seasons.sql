-- 5. seasons
CREATE TABLE seasons (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SEAS',
    name VARCHAR(50) NOT NULL, -- e.g. "2023-2024"
    start_date DATE,
    end_date DATE,
    is_current BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seasons ENABLE ROW LEVEL SECURITY;

-- Data for seasons
INSERT INTO seasons (id, name, start_date, end_date, is_current) VALUES
(gen_random_uuid(), '2023-2024', '2023-09-01', '2024-05-31', FALSE),
(gen_random_uuid(), '2024-2025', '2024-09-01', '2025-05-31', FALSE),
(gen_random_uuid(), '2025-2026', '2025-09-01', '2026-05-31', FALSE),
(gen_random_uuid(), '2026-2027', '2026-09-01', '2027-05-31', TRUE);
