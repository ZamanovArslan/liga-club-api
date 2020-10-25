class Partner < ApplicationRecord
  validates :name, presence: true

  belongs_to :city, optional: true

  mount_uploader :image, BaseUploader
end
