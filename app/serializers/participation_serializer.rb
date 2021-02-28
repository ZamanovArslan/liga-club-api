class ParticipationSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :confirmed, :badge_id, :attachment_confirmation, :text_confirmation, :status

  has_one :user

  def attachment_confirmation
    attachment(:attachment_confirmation)
  end
end
