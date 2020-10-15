module V1
  class UsersController < V1::BaseController
    expose :users, -> { FilteredUsersQuery.new(rank_query, permitted_filter_params).all }
    expose :user, scope: -> { rank_query }

    def index
      respond_with users, each_serializer: UserLeaderboardSerializer
    end

    def show
      respond_with user, serializer: UserLeaderboardSerializer
    end

    private

    def rank_query
      UserLeaderboardQuery.new(User.includes({ university: :city }, :phone)).all
    end

    def permitted_filter_params
      params.permit(:page, :per_page, :full_name, :university_id, :city_id)
    end
  end
end
