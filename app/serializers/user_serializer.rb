class UserSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :full_name, :group_number, :avatar, :score

  has_one :university
  has_one :level

  def avatar
    attachment(:avatar)
  end
end
