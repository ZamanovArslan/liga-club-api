class User < ApplicationRecord
  has_secure_password

  validates :full_name, :group_number, :phone_number, presence: true
  validates :phone_number, uniqueness: true

  has_one :code, dependent: :destroy
  has_many :confirmed_participations, -> { confirmed }, dependent: :destroy, class_name: "Participation",
           inverse_of: :user
  has_many :badges, through: :confirmed_participations

  belongs_to :university, dependent: :destroy

  mount_uploader :avatar, BaseUploader

  def scores_count
    badges.joins(:rarity).sum(:scores_count)
  end

  def level
    Level.where("scores_count <= ?", scores_count).max_by(&:scores_count)
  end
end
