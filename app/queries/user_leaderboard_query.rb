class UserLeaderboardQuery
  attr_reader :relation

  FROM_QUERY = <<~SQL.squish.freeze
    (SELECT users.*, RANK() OVER (ORDER BY users.high_score DESC) AS rank
      FROM (SELECT users.id, MAX(score) AS high_score
            FROM users WHERE id IN (%{user_ids})
            GROUP BY id) AS users
      ORDER BY "rank" ASC) AS ranked_users
  SQL

  def initialize(relation = User.all)
    @relation = relation
  end

  def all
    User.select("*")
      .from(format(FROM_QUERY, user_ids: relation.pluck(:id).join(",").presence || "-1"))
      .joins("INNER JOIN users ON users.id = ranked_users.id")
      .order(rank: :asc)
  end
end
