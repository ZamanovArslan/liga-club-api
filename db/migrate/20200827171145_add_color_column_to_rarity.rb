class AddColorColumnToRarity < ActiveRecord::Migration[6.0]
  def change
    add_column :rarities, :color, :string
  end
end
