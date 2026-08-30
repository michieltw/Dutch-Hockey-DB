-- 18. points_ledger
CREATE TABLE points_ledger (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'PTLG',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    points INTEGER,
    reason TEXT,
    transaction_date TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE points_ledger ENABLE ROW LEVEL SECURITY;
