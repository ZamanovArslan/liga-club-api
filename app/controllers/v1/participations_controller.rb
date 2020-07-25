module V1
  class ParticipationsController < V1::BaseController
    def create
      participation = Participation.create(user: current_user, badge_id: params[:badge_id])

      if participation.save
        respond_with participation, each_serializer: ParticipationSerializer
      else
        respond_with_invalid_credentials participation.errors
      end
    end

    private

    def authentication_params
      params.require(:user).permit(:phone_number, :password)
    end
  end
end
