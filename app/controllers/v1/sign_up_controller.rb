module V1
  class SignUpController < V1::BaseController
    skip_before_action :authenticate_user!

    def create
      result = Users::Create.call(params: user_params)

      if result.success?
        respond_with result.user
      else
        respond_with_error result.error
      end
    end

    private

    def user_params
      params.require(:user).permit(:full_name, :email, :password, :group_number, :phone_number, :code_value)
    end
  end
end
