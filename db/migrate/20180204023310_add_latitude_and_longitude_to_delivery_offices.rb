class AddLatitudeAndLongitudeToDeliveryOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :delivery_offices, :latitude, :float
    add_column :delivery_offices, :longitude, :float
  end
end
