class User < ApplicationRecord
  has_secure_password

  validates :full_name, :group_number, :phone_number, presence: true
  validates :password, length: { minimum: 6 }
  validates :phone_number, uniqueness: true

  has_one :code, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :badges, through: :participations do
    -> { confirmed }
  end

  belongs_to :university, dependent: :destroy

  def scores_count
    participations.confirmed.joins(badge: :rarity).sum(:scores_count)
  end
end
