class Code < ApplicationRecord
  validates :value, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user, optional: true
end
