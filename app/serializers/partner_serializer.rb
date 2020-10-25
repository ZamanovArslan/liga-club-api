class PartnerSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :discount, :instagram_link, :image

  belongs_to :city

  alias image attachment
end
