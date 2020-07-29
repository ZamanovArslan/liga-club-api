module V1
  class ParticipationsController < V1::BaseController
    def create
      participation = Participation.create(user: current_user, badge_id: params[:badge_id])

      if participation.save
        respond_with participation, each_serializer: ParticipationSerializer, include: "user.university"
      else
        respond_with_invalid_credentials participation.errors_messages
      end
    end
  end
end
