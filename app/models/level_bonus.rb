class LevelBonus < ApplicationRecord
  belongs_to :level
  belongs_to :bonus

  validates :level, uniqueness: { scope: :bonus }
end
