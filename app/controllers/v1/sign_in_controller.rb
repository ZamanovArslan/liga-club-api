module V1
  class SignInController < V1::BaseController
    skip_before_action :authenticate_user!

    def create
      result = Users::CreateJwt.call(authentication_params)

      if result.success?
        respond_with result.jwt_token, root: "token"
      else
        respond_with_invalid_credentials result.error
      end
    end

    private

    def authentication_params
      params.require(:user).permit(:phone_number, :password)
    end
  end
end
