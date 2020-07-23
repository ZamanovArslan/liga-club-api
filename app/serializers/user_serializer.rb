class UserSerializer < ApplicationSerializer
  include ImageSerializer

  attributes :id, :full_name, :group_number, :phone_number, :university_id, :avatar, :scores_count

  def avatar
    attachment(:avatar)
  end
end
