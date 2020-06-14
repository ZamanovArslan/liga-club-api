class BadgeSerializer < ApplicationSerializer
  attributes :id, :name, :description
  has_one :rarity
  has_one :university
end
