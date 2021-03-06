module V1
  class BaseController < ActionController::API
    include Knock::Authenticable

    before_action :authenticate_user!

    self.responder = ::ApiResponder
    respond_to :json

    rescue_from ActiveRecord::RecordNotFound do |_exception|
      respond_with_error(code: :record_not_found)
    end

    private

    def respond_with_invalid_credentials(validations)
      respond_with_error(code: :invalid_credentials, validations: validations)
    end

    def authenticate_user!
      respond_with_error(code: :unauthorized) unless current_user
    end

    def respond_with_error(error_data)
      Error.new(error_data).tap do |error|
        render json: error.to_json, status: error.status
      end
    end

    def current_user
      @current_user ||= token && authenticate_for(User)
    end
  end
end
