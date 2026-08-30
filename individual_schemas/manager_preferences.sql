-- manager_preferences.sql
CREATE TABLE manager_preferences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ini_code VARCHAR(4) DEFAULT 'MGRC',
    user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE CASCADE,
    auto_accept_minor_trades BOOLEAN DEFAULT FALSE,
    trade_block_visible BOOLEAN DEFAULT TRUE,
    ai_assistant_enabled BOOLEAN DEFAULT FALSE,
    preferred_scouting_region UUID REFERENCES regions(id) ON DELETE SET NULL,
    default_contract_length INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ,
    deleted_at TIMESTAMPTZ
);

CREATE INDEX idx_manager_preferences_user_id ON manager_preferences(user_id);
CREATE INDEX idx_manager_preferences_preferred_scouting_region ON manager_preferences(preferred_scouting_region);

ALTER TABLE manager_preferences ENABLE ROW LEVEL SECURITY;
