class UserSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :full_name, :group_number, :phone_number, :university_id, :avatar

  def avatar
    attachment(:avatar)
  end
end
