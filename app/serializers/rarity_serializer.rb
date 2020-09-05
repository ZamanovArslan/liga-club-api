class RaritySerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :image, :color
  alias image attachment
end
