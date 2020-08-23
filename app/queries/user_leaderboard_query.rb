class UserLeaderboardQuery
  attr_reader :relation

  SUBQUERY = <<-SQL
    (SELECT *, MAX(score) AS high_score
    FROM users
    GROUP BY id
    ) AS users
  SQL

  SELECT_QUERY = "*, RANK() OVER (ORDER BY users.high_score DESC) AS rank"

  def initialize(relation = User.all)
    @relation = relation
  end

  def all
    relation.select(SELECT_QUERY).from(SUBQUERY).order(rank: :asc)
  end
end