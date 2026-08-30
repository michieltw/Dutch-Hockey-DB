-- 31. trivia_answers
CREATE TABLE trivia_answers (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'TRVA',
    question_id UUID NOT NULL REFERENCES trivia_questions(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    user_answer TEXT,
    is_correct BOOLEAN,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE trivia_answers ENABLE ROW LEVEL SECURITY;
