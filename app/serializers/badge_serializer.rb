class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image
  has_one :rarity
  has_one :university
  alias_method :image, :attachment
end
