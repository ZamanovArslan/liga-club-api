class AddParticipationConditionsToBadge < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :participation_terms, :text
  end
end
