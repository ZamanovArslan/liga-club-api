module Users
  class CreateJwt
    include Interactor

    delegate :phone_number, :password, to: :context

    def call
      context.fail!(error: I18n.t("errors.services.sign_in.invalid_credentials")) unless authenticated?
      context.jwt_token = jwt_token
    end

    private

    def authenticated?
      user.present? && user.authenticate(password)
    end

    def jwt_token
      JwtToken.new(payload: { sub: user.id })
    end

    def user
      @user ||= User.find_by(phone_number: phone_number)
    end
  end
end
