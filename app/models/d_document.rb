class DDocument < ApplicationRecord
  belongs_to :operation
  belongs_to :d_template
  belongs_to :user, optional: true

  validates :user, presence: true #if: :d_document_is_a_subscription_bund?


  # def d_document_is_a_subscription_bund?
  #   document_type == "subscription_bund"
  # end
end
