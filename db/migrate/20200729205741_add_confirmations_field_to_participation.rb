class AddConfirmationsFieldToParticipation < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :text_confirmation, :string
    add_column :participations, :attachment_confirmation, :string
  end
end
