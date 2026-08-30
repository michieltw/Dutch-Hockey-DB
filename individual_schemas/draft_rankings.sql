-- 11. draft_rankings
CREATE TABLE draft_rankings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'DRRK',
    prospect_id UUID NOT NULL REFERENCES draft_prospects(id) ON DELETE CASCADE,
    source_name VARCHAR(100), -- 'EliteProspects', 'Central Scouting'
    rank_position INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE draft_rankings ENABLE ROW LEVEL SECURITY;
