class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :parking, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status
      t.string :type_booked
      t.string :car_number
      t.integer :price

      t.timestamps
    end
  end
end
