class FilteredUsersQuery < BaseFilteredQuery
  ALLOWED_PARAMS = %i[full_name university_id].freeze
  SEARCH_SQL = <<-SQL.squish.freeze
    lower(users.first_name) similar to lower(:full_name) ESCAPE '^' OR
    lower(users.last_name) similar to lower(:full_name) ESCAPE '^'
  SQL

  private

  def by_full_name(relation, full_name)
    full_name = prepare_query_to_search(full_name)

    relation.where(SEARCH_SQL, full_name: full_name)
  end

  def by_city_id(relation, city_id)
    relation.where(universities: { city_id: city_id })
  end

  def by_university_id(relation, university_id)
    relation.where(university_id: university_id)
  end
end
