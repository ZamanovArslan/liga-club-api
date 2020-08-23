module V1
  class UsersController < V1::BaseController
    expose :users, -> { rank_query }
    expose :user, scope: -> { rank_query }

    def index
      respond_with users, each_serializer: UserLeaderboardSerializer
    end

    def show
      respond_with user, serializer: UserLeaderboardSerializer
    end

    private

    def rank_query
      UserLeaderboardQuery.new(default_query).all
    end

    def default_query
      User.all.page(params[:page]).per(params[:per_page])
    end
  end
end
