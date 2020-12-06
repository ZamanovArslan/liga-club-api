class LevelSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :description, :image, :bonus_description

  alias image attachment
end
