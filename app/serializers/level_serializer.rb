class LevelSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :scores_count, :description

  def image
    attachment(:image)
  end
end
