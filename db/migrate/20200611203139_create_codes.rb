class CreateCodes < ActiveRecord::Migration[6.0]
  def change
    create_table :codes do |t|
      t.string :value, null: false
      t.references :user, index: true, foreign_key: true
    end
  end
end
