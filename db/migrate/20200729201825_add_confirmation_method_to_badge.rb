class AddConfirmationMethodToBadge < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :confirmation_method, :string
  end
end
