class Level < ApplicationRecord
  validates :name, :scores_count, presence: true
end
