class UserLeaderboardQuery
  attr_reader :relation

  FROM_QUERY = <<~SQL.squish.freeze
    (SELECT users.*, RANK() OVER (ORDER BY users.high_score DESC) AS rank
      FROM (SELECT id, MAX(score) AS high_score
            FROM (%{relation}) as users
            GROUP BY id) AS users
      ORDER BY "rank" ASC) AS ranked_users
  SQL

  def initialize(relation = User.all)
    @relation = relation
  end

  def all
    User.select("*")
      .from(format(FROM_QUERY, relation: relation.to_sql))
      .joins("INNER JOIN users ON users.id = ranked_users.id")
      .order(rank: :asc)
  end
end
