class RemoveRedundantConstraintsFromBadge < ActiveRecord::Migration[6.0]
  def change
    change_column :badges, :description, :string, :null => true
    change_column :badges, :ends_at, :string, :null => true
  end
end
