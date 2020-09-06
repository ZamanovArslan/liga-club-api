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
      Badge.actual.with_university(current_user.university.id)
    end
  end
end
