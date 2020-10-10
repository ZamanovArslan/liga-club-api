class ChangeBadgeEndsAtToDateTime < ActiveRecord::Migration[6.0]
  def change
    remove_column :badges, :ends_at, :string

    add_column :badges, :ends_at, :datetime, null: true
  end
end
