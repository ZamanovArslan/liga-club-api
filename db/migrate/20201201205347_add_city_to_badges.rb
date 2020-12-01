class AddCityToBadges < ActiveRecord::Migration[6.0]
  def change
    add_reference :badges, :city, foreign_key: true
  end
end
