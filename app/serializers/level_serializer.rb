class LevelSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :description, :image
  alias image attachment
end
