class PartnerSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :discount, :instagram_link, :image
  alias image attachment
end
