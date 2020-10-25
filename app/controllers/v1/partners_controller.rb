module V1
  class PartnersController < V1::BaseController
    skip_before_action :authenticate_user!

    expose :partners, -> { Partner.includes(:city) }

    def index
      respond_with partners, each_serializer: PartnerSerializer
    end
  end
end
