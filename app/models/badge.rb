class Badge < ApplicationRecord
  belongs_to :rarity
  belongs_to :university, optional: true

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
end
