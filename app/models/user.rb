class User < ApplicationRecord
  has_secure_password

  validates :full_name, :group_number, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_one :phone, dependent: :destroy
  has_many :participations, dependent: :destroy, inverse_of: :user
  has_many :confirmed_participations, -> { confirmed }, class_name: "Participation", inverse_of: :user
  has_many :badges, through: :confirmed_participations

  belongs_to :university

  mount_uploader :avatar, BaseUploader

  def level
    Level.where("scores_count <= ?", score).max_by(&:scores_count)
  end
end
