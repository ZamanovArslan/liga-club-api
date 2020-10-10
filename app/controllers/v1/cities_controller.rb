module V1
  class CitiesController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :cities, -> { City.all }

    def index
      respond_with cities, each_serializer: CitySerializer
    end
  end
end
