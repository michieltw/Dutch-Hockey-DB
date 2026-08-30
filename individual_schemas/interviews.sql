-- 37. interviews
CREATE TABLE interviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INTV',
    article_id UUID NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    interviewee_person_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE interviews ENABLE ROW LEVEL SECURITY;
