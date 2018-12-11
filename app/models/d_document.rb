class DDocument < ApplicationRecord
  belongs_to :operation
  belongs_to :user, optional: true

  validates :document_type, inclusion: { in: ['pv_opening', 'subscription_bund', 'pv_closing'] }
  validates :user, presence: true, if: :d_document_is_a_subscription_bund?


  def d_document_is_a_subscription_bund?
    document_type == "subscription_bund"
  end
end

#créer une variable qui stocke tous les document_types
