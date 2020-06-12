module V1
  class UniversitiesController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :universities, -> { University.all }
    expose :university

    def index
      respond_with universities
    end

    def show
      respond_with university
    end
  end
end
