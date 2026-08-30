-- 30. trivia_questions
CREATE TABLE trivia_questions (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRVQ',
    question TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    points INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trivia_questions ENABLE ROW LEVEL SECURITY;
