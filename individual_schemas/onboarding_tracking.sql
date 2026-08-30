-- onboarding_tracking.sql
CREATE TABLE onboarding_tracking (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'ONBT',
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role user_role_enum,
    has_completed_welcome BOOLEAN DEFAULT FALSE,
    has_configured_profile BOOLEAN DEFAULT FALSE,
    has_setup_team BOOLEAN DEFAULT FALSE,
    has_setup_league_rules BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_onboarding_tracking_user_id ON onboarding_tracking(user_id);

ALTER TABLE onboarding_tracking ENABLE ROW LEVEL SECURITY;
