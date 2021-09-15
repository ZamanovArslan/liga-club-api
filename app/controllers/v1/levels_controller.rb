module V1
  class LevelsController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :levels, -> { Level.all.order(scores_count: :asc).includes(:bonuses) }
    expose :level

    def index
      respond_with levels, each_serializer: LevelSerializer
    end

    def show
      respond_with level
    end
  end
end
