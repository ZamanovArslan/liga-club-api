module V1
  module My
    class ProfilesController < V1::BaseController
      expose :user, scope: -> { rank_query }, id: -> { current_user.id }

      def show
        respond_with user, serializer: UserLeaderboardSerializer
      end

      def update
        if current_user.update(user_params)
          respond_with current_user
        else
          respond_with_invalid_credentials current_user.errors_messages
        end
      end

      def destroy
        respond_with current_user.destroy
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :password, :group_number, :university_id,
                                     :avatar).merge(password_confirmation: nil)
      end

      def rank_query
        UserLeaderboardQuery.new.all
      end
    end
  end
end
