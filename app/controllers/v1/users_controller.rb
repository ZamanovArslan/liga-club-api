module V1
  class UsersController < V1::BaseController
    expose :users, -> { fetch_users.page(params[:page]).per(params[:per_page]) }
    expose :user, scope: -> { fetch_users }

    def index
      respond_with users, each_serializer: UserLeaderboardSerializer
    end

    def show
      respond_with user, serializer: UserLeaderboardSerializer
    end

    private

    def fetch_users
      UserLeaderboardQuery.new(
        FilteredUsersQuery.new(base_query, permitted_filter_params).all
      ).all
    end

    def base_query
      User.includes({ university: :city }, :phone)
    end

    def permitted_filter_params
      params.permit(:page, :per_page, :full_name, :university_id, :city_id)
    end
  end
end
