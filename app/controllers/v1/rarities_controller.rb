module V1
  class RaritiesController < V1::BaseController
    expose :rarities, -> { Rarity.all }
    expose :rarity

    def index
      respond_with rarities, each_serializer: RaritySerializer
    end

    def show
      respond_with rarity
    end
  end
end
