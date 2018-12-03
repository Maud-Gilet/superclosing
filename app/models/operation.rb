class Operation < ApplicationRecord
  belongs_to :company
  has_many :investments
  has_many :users, through: :investments
  has_many :s_documents
  has_many :d_documents
  has_many :d_templates, through: :d_documents
end
