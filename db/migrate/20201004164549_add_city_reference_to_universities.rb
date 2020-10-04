class AddCityReferenceToUniversities < ActiveRecord::Migration[6.0]
  def change
    remove_column :universities, :city, :string

    add_reference :universities, :city, index: true
  end
end
