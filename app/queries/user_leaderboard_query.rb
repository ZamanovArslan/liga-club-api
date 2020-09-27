class UserLeaderboardQuery
  attr_reader :relation

  SUBQUERY = <<-SQL.freeze
    (SELECT *, RANK() OVER (ORDER BY users.high_score DESC) AS rank FROM 
      (SELECT *, MAX(score) AS high_score
        FROM users
        GROUP BY id
    ) AS users) AS users
  SQL

  def initialize(relation = User.all)
    @relation = relation
  end

  def all
    relation.select("*").from(SUBQUERY).order(rank: :asc)
  end
end
