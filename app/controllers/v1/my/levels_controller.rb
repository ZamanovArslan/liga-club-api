module V1
  module My
    class LevelsController < V1::BaseController
      expose :levels, -> { Level.all }

      def index
        respond_with levels
      end
    end
  end
end
