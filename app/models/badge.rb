class Badge < ApplicationRecord
  belongs_to :rarity
  belongs_to :university, optional: true

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  scope :ended, -> { where("ends_at < ?", Time.zone.now) }
  scope :actual, -> { where("ends_at > ?", Time.zone.now) }

  def ends_at
    self[:ends_at].strftime("%Y-%m-%d %H:%M")
  end
end
