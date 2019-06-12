class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :orderable, polymorphic: true
      t.string :car_number
      t.string :type_booked
      t.integer :status, default: 0
      t.string :month_booked, default: ""
      t.datetime :day_booked, null: true
      t.integer :price

      t.timestamps
    end
  end
end
