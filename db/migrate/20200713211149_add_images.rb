class AddImages < ActiveRecord::Migration[6.0]
  def change
    add_column :users, "avatar", :string
    add_column :levels, "image", :string
    add_column :partners, "image", :string
    add_column :rarities, "image", :string
    add_column :badges, "image", :string
  end
end
