class Rarity < ApplicationRecord
  validates :name, :scores_count, presence: true

  mount_uploader :image, BaseUploader
end
