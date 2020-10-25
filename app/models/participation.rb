class Participation < ApplicationRecord
  self.table_name = :participation

  belongs_to :user
  belongs_to :badge

  scope :confirmed, -> { where(confirmed: true) }

  validates :user, uniqueness: { scope: :badge }
  validate :user_should_be_from_badge_university, if: -> { badge.university }

  mount_uploader :attachment_confirmation, BaseUploader

  private

  def user_should_be_from_badge_university
    return if badge.university == user.university

    errors.add(:badge, :not_a_student, { university_name: badge.university.name })
  end
end
