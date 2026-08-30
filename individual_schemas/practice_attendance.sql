-- 2. practice_attendance
CREATE TABLE practice_attendance (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRAT',
    session_id UUID NOT NULL REFERENCES training_sessions(id) ON DELETE CASCADE,
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    status VARCHAR(50), -- 'Present', 'Absent', 'Excused'
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE practice_attendance ENABLE ROW LEVEL SECURITY;
