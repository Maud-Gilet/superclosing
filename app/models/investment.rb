class Investment < ApplicationRecord
  belongs_to :user
  belongs_to :operation

  monetize :share_nominal_value_cents
  monetize :share_premium_cents
end
