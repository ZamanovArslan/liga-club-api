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
  has_one_attached :photo

  belongs_to :university, dependent: :destroy

  def scores_count
    badges.joins(:rarity).sum(:scores_count)
  end

  def level
    Level.where("scores_count <= ?", scores_count).max_by(&:scores_count)
  end
end
