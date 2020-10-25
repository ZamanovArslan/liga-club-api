module V1
  class SignUpController < V1::BaseController
    skip_before_action :authenticate_user!

    def create
      result = Users::Create.call(params: user_params)

      if result.success?
        respond_with JwtToken.new(payload: { sub: result.user.id }), root: "token"
      else
        respond_with_invalid_credentials result.error
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :group_number, :phone_number,
                                   :university_id, :avatar)
    end
  end
end
