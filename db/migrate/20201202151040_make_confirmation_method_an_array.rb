class MakeConfirmationMethodAnArray < ActiveRecord::Migration[6.0]
  def change
    change_column :badges, :confirmation_method, "varchar[] USING (string_to_array(confirmation_method, ','))"
  end
end
