class AddCityToPartner < ActiveRecord::Migration[6.0]
  def change
    add_reference :partners, :city
  end
end
