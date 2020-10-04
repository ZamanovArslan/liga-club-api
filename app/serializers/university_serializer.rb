class UniversitySerializer < ApplicationSerializer
  attributes :id, :name, :abbreviation

  belongs_to :city
end
