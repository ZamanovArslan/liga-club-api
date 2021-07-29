class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :group_number, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_one :phone, dependent: :destroy
  has_many :participation, dependent: :destroy, inverse_of: :user
  has_many :approved_participation, -> { approved }, class_name: "Participation", inverse_of: :user
  has_many :badges, through: :approved_participation

  belongs_to :university

  mount_uploader :avatar, BaseUploader

  def level
    Level.where("scores_count <= ?", score).max_by(&:scores_count)
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
