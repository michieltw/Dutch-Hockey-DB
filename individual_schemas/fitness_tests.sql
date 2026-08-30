-- 6. fitness_tests
CREATE TABLE fitness_tests (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'FITT',
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    test_date DATE,
    vo2_max NUMERIC(5, 2),
    bench_press_max INTEGER,
    sprint_time NUMERIC(5, 2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE fitness_tests ENABLE ROW LEVEL SECURITY;
