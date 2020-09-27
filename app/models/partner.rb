class Partner < ApplicationRecord
  validates :name, presence: true

  mount_uploader :image, BaseUploader
end
