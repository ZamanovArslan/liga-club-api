class AddCityToUniversities < ActiveRecord::Migration[6.0]
  def change
    add_column :universities, :city, :string
  end
end
