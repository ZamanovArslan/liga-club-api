class Badge < ApplicationRecord
  extend Enumerize

  CONFIRMATION_METHODS = %i[photo text].freeze

  belongs_to :rarity
  belongs_to :university, optional: true

  has_many :participation, dependent: :destroy
  has_many :users, through: :participation

  scope :ended, -> { where("ends_at < ?", Time.zone.now) }
  scope :actual, -> { where("ends_at > ?", Time.zone.now).or(where(ends_at: nil)) }

  validates :name, presence: true
  validates :name, length: { maximum: 30 }

  delegate :scores_count, to: :rarity

  enumerize :confirmation_method, in: CONFIRMATION_METHODS, predicates: true, scope: true

  mount_uploader :image, BaseUploader
end
