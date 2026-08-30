-- 44. commentators
CREATE TABLE commentators (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'CMNT',
    person_id UUID NOT NULL REFERENCES persons(id) ON DELETE CASCADE,
    broadcast_id UUID NOT NULL REFERENCES broadcast_schedules(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE commentators ENABLE ROW LEVEL SECURITY;
