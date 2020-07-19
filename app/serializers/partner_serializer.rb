class PartnerSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :discount, :instagram_link, :image
  alias_method :image, :attachment
end
