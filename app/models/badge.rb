class Badge < ApplicationRecord
  extend Enumerize

  CONFIRMATION_METHODS = %i[photo text].freeze
  SCOPES = %i[university city republic country global].freeze

  belongs_to :rarity
  belongs_to :university, optional: true
  belongs_to :city, optional: true

  has_many :participation, dependent: :destroy
  has_many :users, through: :participation

  scope :ended, -> { where("ends_at < ?", Time.zone.now) }
  scope :actual, -> { where("ends_at > ?", Time.zone.now).or(where(ends_at: nil)) }

  validates :name, :participation_terms, presence: true
  validates :name, length: { maximum: 30 }

  delegate :scores_count, to: :rarity

  enumerize :confirmation_method, in: CONFIRMATION_METHODS, predicates: true, multiple: true
  enumerize :scope, in: SCOPES

  mount_uploader :image, BaseUploader
end
