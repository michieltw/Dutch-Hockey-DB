-- 14. sections
CREATE TABLE sections (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SECT',
    chart_id UUID NOT NULL REFERENCES seating_charts(id) ON DELETE CASCADE,
    name VARCHAR(50),
    capacity INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;
