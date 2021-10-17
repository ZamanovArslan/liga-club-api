class CreateBonuses < ActiveRecord::Migration[6.0]
  def change
    create_table :bonuses do |t|
      t.string :title, null: false
      t.text :description
      t.text :link

      t.timestamps
    end
  end
end
