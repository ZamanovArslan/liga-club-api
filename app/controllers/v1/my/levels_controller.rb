module V1
  module My
    class LevelsController < V1::BaseController
      expose :level, :fetch_level

      def show
        debugger
        respond_with level
      end

      private

      def fetch_level
        Level.where("scores_count <= ?", current_user.scores_count).max_by(&:scores_count)
      end
    end
  end
end
