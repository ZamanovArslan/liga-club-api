module Users
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      context.fail!(error: error_message) if error_message.present?

      user.save
      context.user = user
    end

    private

    def error_message
      @error_message ||= begin
        return I18n.t("errors.services.sign_up.phone_not_found") if phone.blank?
        return I18n.t("errors.services.sign_up.phone_already_taken") if phone.user.present?

        user.phone = phone
        user.errors_messages unless user.valid?
      end
    end

    def user
      @user ||= User.new(params.except(:phone_number))
    end

    def phone
      @phone ||= Phone.find_by(value: params[:phone_number])
    end
  end
end
