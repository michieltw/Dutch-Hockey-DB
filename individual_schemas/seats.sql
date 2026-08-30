-- 16. seats
CREATE TABLE seats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'SEAT',
    row_id UUID NOT NULL REFERENCES rows(id) ON DELETE CASCADE,
    number VARCHAR(50),
    is_accessible BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE seats ENABLE ROW LEVEL SECURITY;
