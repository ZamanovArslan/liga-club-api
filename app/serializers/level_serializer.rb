class LevelSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :description, :image, :bonus_description

  has_many :bonuses

  alias image attachment
end
