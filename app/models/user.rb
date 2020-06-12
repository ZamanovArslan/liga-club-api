class User < ApplicationRecord
  has_secure_password

  validates :full_name, :group_number, :phone_number, presence: true
  validates :password, length: { minimum: 6 }
  validates :phone_number, uniqueness: true

  has_one :code, dependent: :destroy
  has_one :university, dependent: :destroy
end
