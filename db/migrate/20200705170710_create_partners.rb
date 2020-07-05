class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.text :description
      t.integer :discount, default: 0
      t.string :instagram_link

      t.timestamps
    end
  end
end
