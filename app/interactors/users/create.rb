module Users
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      context.fail!(error: :invalid_credentials) if code.blank? || code.user.present? || !user.save

      context.user = user
    end

    private

    def user
      @user = User.new(params.except(:code_value).merge(code: code))
    end

    def code
      @code = Code.find_by(value: params[:code_value])
    end
  end
end
