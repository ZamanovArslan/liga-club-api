class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image, :confirmation_method, :is_participation

  has_one :rarity
  has_one :university

  alias image attachment

  def is_participation

    object.participation?
  end

  def ends_at
    object.ends_at&.strftime("%m.%d.%Y %R")
  end
end
