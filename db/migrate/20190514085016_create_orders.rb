class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :parking, foreign_key: true
      t.references :user, foreign_key: true
      t.string :car_number
      t.string :type_booked
      t.string :status, default: "Đã đặt"
      t.string :month_booked, default: ""
      t.datetime :day_booked, null: true
      t.integer :price

      t.timestamps
    end
  end
end
