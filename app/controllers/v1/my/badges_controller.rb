module V1
  module My
    class BadgesController < V1::BaseController
      expose :badges, :fetch_badges

      def index
        respond_with badges, each_serializer: BadgeParticipationSerializer
      end

      def fetch_badges
        ParticipationQuery.new(current_user, Badge.where(id: current_user.badges.pluck(:id)).includes(:university, :rarity)).all
      end
    end
  end
end
