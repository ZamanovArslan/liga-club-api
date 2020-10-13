class ParticipationQuery
  attr_reader :relation, :user
  SELECT_QUERY = <<~SQL
    badges.id, CASE WHEN participation.user_id = %{id} THEN true ELSE false END AS participation
  SQL

  def initialize(user, relation = Badge.all)
    @relation = relation
    @user = user
  end

  def all
    relation.select("*, true AS is_participation").from(relation.joins(:participation).where(participation: {user_id: user.id}).to_sql)
  end
end
