module V1
  class NewsController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :news, -> { News.all.order(created_at: :desc) }

    def index
      respond_with news, each_serializer: NewsSerializer
    end
  end
end
