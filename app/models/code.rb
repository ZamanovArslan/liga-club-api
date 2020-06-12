class Code < ApplicationRecord
  validates :value, presence: true, uniqueness: true

  belongs_to :user, optional: true
end
