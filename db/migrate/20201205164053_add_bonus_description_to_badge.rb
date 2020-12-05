class AddBonusDescriptionToBadge < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :bonus_description, :text
  end
end
