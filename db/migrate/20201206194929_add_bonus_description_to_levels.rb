class AddBonusDescriptionToLevels < ActiveRecord::Migration[6.0]
  def change
    add_column :levels, :bonus_description, :text
  end
end
