module V1
  class VerifyCodeController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :code, find_by: :value, id: :value

    def show
      respond_with code
    end
  end
end
