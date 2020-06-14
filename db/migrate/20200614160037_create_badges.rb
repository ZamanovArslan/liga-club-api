class CreateBadges < ActiveRecord::Migration[6.0]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.integer :description, null: false
      t.datetime :ends_at, null: false
      t.references :rarity, null: false, foreign_key: true
      t.references :university, foreign_key: true

      t.timestamps
    end
  end
end
