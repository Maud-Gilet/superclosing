class Company < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :operations
end
