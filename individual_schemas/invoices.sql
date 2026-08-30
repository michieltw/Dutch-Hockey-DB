-- 33. invoices
CREATE TABLE invoices (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'INVO',
    club_id UUID NOT NULL REFERENCES clubs(id) ON DELETE CASCADE,
    issued_to_person_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    issued_to_org_id UUID REFERENCES organizations(id) ON DELETE SET NULL,
    amount NUMERIC(12, 2),
    issue_date DATE,
    due_date DATE,
    status VARCHAR(50), -- 'Paid', 'Unpaid', 'Overdue'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
