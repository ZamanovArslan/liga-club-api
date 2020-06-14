class ParticipationSerializer < ApplicationSerializer
  attributes :id, :confirmed?
  has_one :user
  has_one :badge

  validates :user, uniqueness: true, scope: :badge
end
