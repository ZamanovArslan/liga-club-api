class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image, :confirmation_method

  has_one :rarity
  has_one :university

  alias image attachment

  def ends_at
    object.ends_at&.strftime("%m.%d.%Y %R")
  end
end
