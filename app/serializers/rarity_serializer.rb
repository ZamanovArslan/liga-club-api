class RaritySerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :image
  alias image attachment
end
