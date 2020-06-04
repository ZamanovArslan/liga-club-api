module V1
  class SignInController < V1::BaseController
    skip_before_action :authenticate_user!

    def create
      result = Users::CreateJwt.call(authentication_params)

      if result.success?
        respond_with result.jwt_token, root: "token"
      else
        respond_with_error result.error
      end
    end

    private

    def authentication_params
      params.require(:user).permit(:email, :password)
    end
  end
end
