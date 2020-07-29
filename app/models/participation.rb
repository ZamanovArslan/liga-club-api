class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :confirmed, -> { where(confirmed: true) }

  validates :user, uniqueness: { scope: :badge }

  mount_uploader :attachment_confirmation, BaseUploader
end
