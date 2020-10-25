class University < ApplicationRecord
  has_many :students, class_name: "User", dependent: :destroy
  belongs_to :city, optional: true

  validates :name, presence: true
end
