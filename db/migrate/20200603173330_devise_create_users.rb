# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name,  null: false
      t.string :email, null: false
      t.string :group_number, null: false
      t.string :phone_number, null: false
      t.string :password_digest, null: false
      
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
