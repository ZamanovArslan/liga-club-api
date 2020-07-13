class JwtTokenSerializer < ApplicationSerializer
  attributes :value

  def value
    object.token
  end
end
