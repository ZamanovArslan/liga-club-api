class AddIndexToScoreUserColumn < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :score
  end
end
