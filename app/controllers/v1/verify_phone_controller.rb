module V1
  class VerifyPhoneController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :phone, find_by: :value, id: :value

    def show
      respond_with phone
    end
  end
end
