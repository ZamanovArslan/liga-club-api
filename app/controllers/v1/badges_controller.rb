module V1
  class BadgesController < V1::BaseController
    expose :badges, -> { Badge.actual }
    expose :badge

    def index
      respond_with badges, each_serializer: BadgeSerializer
    end

    def show
      respond_with badge
    end
  end
end
