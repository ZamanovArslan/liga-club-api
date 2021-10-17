class Level < ApplicationRecord
  has_many :level_bonuses, dependent: :destroy
  has_many :bonuses, through: :level_bonuses

  validates :name, :scores_count, presence: true
  validates :name, length: { maximum: 20 }

  mount_uploader :image, BaseUploader
end
