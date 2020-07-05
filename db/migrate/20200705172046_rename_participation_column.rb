class RenameParticipationColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :participations, :confirmed?, :confirmed
  end
end
