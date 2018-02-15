class CreateDeliveryOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_offices do |t|
      t.string :name
      t.string :address
      t.string :postcode

      t.timestamps
    end
  end
end
