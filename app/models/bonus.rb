class Bonus < ApplicationRecord
  has_many :level_bonuses, dependent: :destroy
  has_many :levels, through: :level_bonuses

  validates :title, presence: true
end
