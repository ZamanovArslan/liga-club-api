module V1
  class PartnersController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :partners, -> { PartnersQuery.new(Partner.includes(:city), filter_params).all }

    def index
      respond_with partners, each_serializer: PartnerSerializer
    end

    private

    def filter_params
      params.permit(:city_id)
    end
  end
end
