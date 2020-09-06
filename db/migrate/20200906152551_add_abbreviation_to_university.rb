class AddAbbreviationToUniversity < ActiveRecord::Migration[6.0]
  def change
    add_column :universities, :abbreviation, :string
  end
end
