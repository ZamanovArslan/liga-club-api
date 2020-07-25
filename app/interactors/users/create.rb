module Users
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      context.fail!(error: error_message) if error_message.present?

      context.user = user
    end

    private

    def user
      @user = User.new(params.except(:code_value).merge(code: code))
    end

    def code
      @code = Code.find_by(value: params[:code_value])
    end

    def error_message
      return I18n.t("errors.services.sign_up.code_not_found") if code.blank?
      return I18n.t("errors.services.sign_up.code_already_taken") if code.user.present?

      user.errors_messages unless user.save
    end
  end
end
