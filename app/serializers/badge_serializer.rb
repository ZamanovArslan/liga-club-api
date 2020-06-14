class BadgeSerializer < ApplicationSerializer
  attributes :id, :name, :description, :ends_at
  has_one :rarity
  has_one :university
end
