module V1
  class BadgesController < V1::BaseController
    expose :badges, :fetch_badges
    expose :badge, -> { ParticipationQuery.new(current_user, Badge.where(id: params[:id])).all.first }

    def index
      respond_with badges, each_serializer: BadgeParticipationSerializer
    end

    def show
      respond_with badge, serializer: BadgeParticipationSerializer
    end

    private

    def fetch_badges
      ParticipationQuery.new(current_user, BadgesQuery.new(Badge.includes(:university, :rarity), filter_params).all).all
    end

    def filter_params
      params.permit(:page, :per_page, :actual, :university_id, :city_id, :rarity_id, :name)
    end
  end
end
