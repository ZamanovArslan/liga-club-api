class User < ApplicationRecord
  has_secure_password

  validates :full_name, :group_number, :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_one :code, dependent: :destroy
  has_many :confirmed_participations, -> { confirmed }, dependent: :destroy, class_name: "Participation",
           inverse_of: :user
  has_many :badges, through: :confirmed_participations

  belongs_to :university, dependent: :destroy

  mount_uploader :avatar, BaseUploader

  def level
    Level.where("scores_count <= ?", score).max_by(&:scores_count)
  end
end
