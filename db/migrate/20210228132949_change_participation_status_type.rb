class ChangeParticipationStatusType < ActiveRecord::Migration[6.0]
  def change
    add_column :participation, :status, :string, default: :pending, null: false
  end
end
