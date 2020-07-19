class RaritySerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :image
  alias_method :image, :attachment
end
