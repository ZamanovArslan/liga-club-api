module V1
  module My
    class ProfilesController < V1::BaseController
      def show
        respond_with current_user
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
        params.require(:user).permit(:full_name, :phone_number, :password, :group_number, :university_id)
          .merge(password_confirmation: nil)
      end
    end
  end
end
