-- 38. newsletters
CREATE TABLE newsletters (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'NEWS',
    subject VARCHAR(255),
    content TEXT,
    sent_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE newsletters ENABLE ROW LEVEL SECURITY;
