class AddUniqIndexToCodeValue < ActiveRecord::Migration[6.0]
  def change
    add_index :codes, [:user_id, :value], unique: true
  end
end
