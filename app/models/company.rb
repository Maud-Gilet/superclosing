class Company < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :operations

  mount_uploader :logo_url, PhotoUploader
end
