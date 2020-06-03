class User < ApplicationRecord
  has_secure_password

  validates :email, :full_name, :group_number, :phone_number, presence: true
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
