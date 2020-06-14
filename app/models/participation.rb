class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :confirmed, -> { where(confirmed?: true) }
end
