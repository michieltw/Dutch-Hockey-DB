-- 29. prediction_results
CREATE TABLE prediction_results (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PRES',
    prediction_id UUID NOT NULL REFERENCES predictions(id) ON DELETE CASCADE,
    is_correct BOOLEAN,
    points_awarded INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE prediction_results ENABLE ROW LEVEL SECURITY;
