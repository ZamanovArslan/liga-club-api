class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :confirmed, -> { where(confirmed: true) }

  validates :user, uniqueness: { scope: :badge }
end
