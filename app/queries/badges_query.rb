class BadgesQuery < BaseFilteredQuery
  ALLOWED_PARAMS = %i[page per_page actual university_id city_id rarity_id name].freeze

  private

  def by_city_id(relation, city_id)
    relation.where(universities: { city_id: city_id})
  end

  def by_actual(relation, actuality)
    actuality ? relation.actual : relation.ended
  end

  def by_rarity_id(relation, rarity_id)
    relation.where(rarity_id: rarity_id)
  end

  def by_name(relation, name)
    name = prepare_query_to_search(name)

    relation.where(SEARCH_SQL, name: name)
  end

  def by_university_id(relation, university_id)
    relation.where(university_id: university_id)
  end
end
