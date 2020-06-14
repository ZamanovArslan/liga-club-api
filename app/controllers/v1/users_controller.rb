module V1
  class UsersController < V1::BaseController
    expose :users, -> { User.all }
    expose :user

    def index
      respond_with users
    end

    def show
      respond_with user
    end
  end
end
