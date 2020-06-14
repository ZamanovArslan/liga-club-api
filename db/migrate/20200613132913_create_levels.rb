class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.string :name, null: false
      t.integer :scores_count, null: false, default: 0
      t.text :description

      t.timestamps
    end
  end
end
