class CreateLevelBonuses < ActiveRecord::Migration[6.0]
  def change
    create_table :level_bonuses do |t|
      t.references :level, null: false, foreign_key: true
      t.references :bonus, null: false, foreign_key: true

      t.timestamps
    end

    add_index :level_bonuses, [:level_id, :bonus_id], unique: true
  end
end
