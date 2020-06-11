module Users
  class Create
    include Interactor

    delegate :params, to: :context

    def call
      context.fail!(error: :invalid_credentials) unless Code.exists?(value: params[:code_value])
      context.user = user
    end

    private

    def user
      User.create(params.except(:code_value))
    end
  end
end
