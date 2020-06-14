class CreateParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true
      t.boolean :confirmed?, null: false, default: false

      t.timestamps
    end

    add_index :participations, [:user_id, :badge_id], unique: true
  end
end
