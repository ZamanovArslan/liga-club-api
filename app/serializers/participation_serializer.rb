class ParticipationSerializer < ApplicationSerializer
  attributes :id, :confirmed, :badge_id
  has_one :user
end
