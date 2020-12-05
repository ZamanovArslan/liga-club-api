class PartnersQuery < BaseFilteredQuery
  ALLOWED_PARAMS = %i[city_id].freeze

  private

  def by_city_id(relation, city_id)
    relation.where(city_id: city_id)
  end
end
