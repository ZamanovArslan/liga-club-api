class CreateRarities < ActiveRecord::Migration[6.0]
  def change
    create_table :rarities do |t|
      t.string :name
      t.integer :scores_count

      t.timestamps
    end
  end
end
