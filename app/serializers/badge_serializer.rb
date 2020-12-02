class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image, :confirmation_method, :scope

  has_one :rarity
  has_one :university

  alias image attachment

  delegate :scope, to: :object

  def confirmation_method
    object.confirmation_method.to_a
  end

  def ends_at
    object.ends_at&.strftime("%m.%d.%Y %R")
  end
end
