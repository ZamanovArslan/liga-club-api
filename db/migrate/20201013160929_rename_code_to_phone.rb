class RenameCodeToPhone < ActiveRecord::Migration[6.0]
  def change
    rename_table :codes, :phones
  end
end
