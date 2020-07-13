module V1
  module My
    class BadgesController < V1::BaseController
      expose :badges, from: :current_user

      def index
        respond_with badges, each_serializer: BadgeSerializer
      end
    end
  end
end
