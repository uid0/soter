class Role < ApplicationRecord
    belongs_to :user
  
    # The grade a role grants access to
    validates :grade, inclusion: { in: [:public, :PII, :PHI, :PCI] }
  end