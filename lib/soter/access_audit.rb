class AccessAudit < ApplicationRecord
    belongs_to :user
    belongs_to :record, polymorphic: true
  
    validates :user_id, :record_id, :field_name, :accessed_at, presence: true
  end