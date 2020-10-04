module V1
  class BadgesController < V1::BaseController
    expose :badges, :fetch_badges
    expose :badge

    def index
      respond_with badges, each_serializer: BadgeSerializer
    end

    def show
      respond_with badge
    end

    private

    def fetch_badges
      BadgesQuery.new(Badge.includes(:university), filter_params).all
    end

    def filter_params
      params.permit(:page, :per_page, :actual, :university_id, :city_id, :rarity_id)
    end
  end
end
