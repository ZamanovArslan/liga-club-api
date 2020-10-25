class UserSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :first_name, :last_name, :full_name, :group_number, :avatar, :score, :phone_number

  has_one :university
  has_one :level

  def avatar
    attachment(:avatar)
  end

  def phone_number
    object.phone.value
  end
end
