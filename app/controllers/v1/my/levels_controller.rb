module V1
  module My
    class LevelsController < V1::BaseController
      expose :levels, -> { Level.where("scores_count < ?", current_user.scores_count) }

      def index
        respond_with levels
      end
    end
  end
end
