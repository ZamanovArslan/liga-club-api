module V1
  module My
    class LevelController < V1::BaseController
      def show
        respond_with current_user.level
      end
    end
  end
end
