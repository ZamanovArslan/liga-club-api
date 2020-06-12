class AddToCodeUniqConstraint < ActiveRecord::Migration[6.0]
  def change
    add_index :codes, :value, unique: true
  end
end
