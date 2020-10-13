class ChangeParticipationsToParticipation < ActiveRecord::Migration[6.0]
  def change
    rename_table :participations, :participation
  end
end
