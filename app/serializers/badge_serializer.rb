class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image, :confirmation_method, :is_participation

  has_one :rarity
  has_one :university

  alias image attachment

  def is_participation
    object.participations.exists?(user: current_user)
  end

  def ends_at
    object.ends_at.to_datetime.strftime("%m.%d.%Y %R")
  end
end
