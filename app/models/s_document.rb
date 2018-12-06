class SDocument < ApplicationRecord
  belongs_to :operation

  mount_uploader :d_url, PhotoUploader
end
