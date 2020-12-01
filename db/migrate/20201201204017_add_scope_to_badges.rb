class AddScopeToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :scope, :string, null: false, default: :republic
  end
end
