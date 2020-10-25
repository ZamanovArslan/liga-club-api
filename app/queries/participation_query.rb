class ParticipationQuery
  attr_reader :relation, :user

  SELECT_QUERY = <<~SQL.freeze
    badges.*, CASE WHEN participation.id IS NULL THEN false ELSE true END AS is_participation
  SQL

  def initialize(user, relation = Badge.all)
    @relation = relation
    @user = user
  end

  def all
    relation.select(SELECT_QUERY)
      .joins("LEFT OUTER JOIN (#{user_participation}) participation ON participation.badge_id = badges.id")
  end

  private

  def user_participation
    user.participation.to_sql
  end
end
