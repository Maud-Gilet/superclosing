class DDocument < ApplicationRecord
  belongs_to :operation
  belongs_to :d_template
end
