class Company < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :operations

  monetize :share_nominal_value_cents

  mount_uploader :logo_url, PhotoUploader
end
