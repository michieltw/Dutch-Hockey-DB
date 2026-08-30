-- staff_attributes
CREATE TABLE staff_attributes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'STAT',
    staff_id UUID NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    -- Business Management
    business INTEGER CHECK (business BETWEEN 1 AND 100),
    interference INTEGER CHECK (interference BETWEEN 1 AND 100),
    patience INTEGER CHECK (patience BETWEEN 1 AND 100),
    resources INTEGER CHECK (resources BETWEEN 1 AND 100),
    -- Mental
    discipline INTEGER CHECK (discipline BETWEEN 1 AND 100),
    man_handling INTEGER CHECK (man_handling BETWEEN 1 AND 100),
    motivating INTEGER CHECK (motivating BETWEEN 1 AND 100),
    youngsters INTEGER CHECK (youngsters BETWEEN 1 AND 100),
    -- Tactics
    attacking INTEGER CHECK (attacking BETWEEN 1 AND 100),
    directness INTEGER CHECK (directness BETWEEN 1 AND 100),
    free_roles INTEGER CHECK (free_roles BETWEEN 1 AND 100),
    line_matching INTEGER CHECK (line_matching BETWEEN 1 AND 100),
    penalty_kill INTEGER CHECK (penalty_kill BETWEEN 1 AND 100),
    physical INTEGER CHECK (physical BETWEEN 1 AND 100),
    power_play INTEGER CHECK (power_play BETWEEN 1 AND 100),
    tactics INTEGER CHECK (tactics BETWEEN 1 AND 100),
    preferred_job VARCHAR(100),
    -- Technical
    coaching_goaltenders INTEGER CHECK (coaching_goaltenders BETWEEN 1 AND 100),
    coaching_defensemen INTEGER CHECK (coaching_defensemen BETWEEN 1 AND 100),
    coaching_forwards INTEGER CHECK (coaching_forwards BETWEEN 1 AND 100),
    coaching_technique INTEGER CHECK (coaching_technique BETWEEN 1 AND 100),
    judgement INTEGER CHECK (judgement BETWEEN 1 AND 100),
    judging_potential INTEGER CHECK (judging_potential BETWEEN 1 AND 100),
    physiotherapy INTEGER CHECK (physiotherapy BETWEEN 1 AND 100),
    evaluated_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);
ALTER TABLE staff_attributes ENABLE ROW LEVEL SECURITY;
