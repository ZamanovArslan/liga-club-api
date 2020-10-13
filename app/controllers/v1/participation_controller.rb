module V1
  class ParticipationController < V1::BaseController
    expose :participation

    def create
      if participation.save
        respond_with participation, include: "user.university"
      else
        respond_with_invalid_credentials participation.errors_messages
      end
    end

    private

    def participation_params
      params.require(:participation).permit(:badge_id, :attachment_confirmation, :text_confirmation)
        .merge(user: current_user)
    end
  end
end
