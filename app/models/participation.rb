class Participation < ApplicationRecord
  extend Enumerize

  self.table_name = :participation

  STATUSES = %i[pending approved rejected].freeze

  belongs_to :user
  belongs_to :badge

  validates :user, uniqueness: { scope: :badge }
  validate :user_should_be_from_badge_university, if: -> { badge.university }

  mount_uploader :attachment_confirmation, BaseUploader

  enumerize :status, in: STATUSES, predicates: true, scope: :shallow

  private

  def user_should_be_from_badge_university
    return if badge.university == user.university

    errors.add(:badge, :not_a_student, { university_name: badge.university.name })
  end
end
