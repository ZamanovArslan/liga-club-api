class Badge < ApplicationRecord
  extend Enumerize

  CONFIRMATION_METHODS = %i(photo text)

  belongs_to :rarity
  belongs_to :university, optional: true

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  scope :ended, -> { where("ends_at < ?", Time.zone.now) }
  scope :actual, -> { where("ends_at > ?", Time.zone.now) }

  enumerize :confirmation_method, in: CONFIRMATION_METHODS, predicates: true, scope: true

  mount_uploader :image, BaseUploader

  def ends_at
    self[:ends_at]&.strftime("%Y-%m-%d %H:%M")
  end
end
