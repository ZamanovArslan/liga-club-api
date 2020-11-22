module V1
  class UsersController < V1::BaseController
    expose :users, -> { fetch_cached_users }
    expose :user, scope: -> { fetch_cached_users }

    def index
      respond_with users, each_serializer: UserLeaderboardSerializer
    end

    def show
      respond_with user, serializer: UserLeaderboardSerializer
    end

    private

    def fetch_cached_users
      return fetch_users.page(params[:page]).per(params[:per_page]) if permitted_filter_params.present?

      Rails.cache.fetch("leaderboard") do
        ActiveModel::SerializableResource.new(fetch_users.page(0).per(25), each_serializer: UserLeaderboardSerializer).to_json
      end
    end

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
