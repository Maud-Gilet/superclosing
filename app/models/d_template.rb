class DTemplate < ApplicationRecord
  has_many :d_documents
  has_many :operations, through: :d_documents
end
