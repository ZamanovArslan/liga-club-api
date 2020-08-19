class Level < ApplicationRecord
  validates :name, :scores_count, presence: true
  validates :name, length: { maximum: 20 }

  mount_uploader :image, BaseUploader
end
