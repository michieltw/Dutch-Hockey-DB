-- 1. training_sessions
CREATE TABLE training_sessions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRNS',
    team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    rink_id UUID REFERENCES rinks(id) ON DELETE SET NULL,
    scheduled_time TIMESTAMPTZ,
    duration_minutes INTEGER,
    focus_area VARCHAR(100),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE training_sessions ENABLE ROW LEVEL SECURITY;
