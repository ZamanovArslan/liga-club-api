class BadgeSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :name, :description, :ends_at, :image, :confirmation_method, :scope, :participation_description,
    :bonus_description

  has_one :rarity
  has_one :university
  belongs_to :city

  alias image attachment

  delegate :scope, to: :object

  def participation_description
    object.participation_terms
  end

  def confirmation_method
    object.confirmation_method.to_a
  end

  def ends_at
    object.ends_at&.strftime("%m.%d.%Y %R")
  end
end
