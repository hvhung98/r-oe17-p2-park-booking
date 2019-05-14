class CreateTimeOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :time_orders do |t|
      t.references :order, foreign_key: true
      t.string :type
      t.datetime :value

      t.timestamps
    end
  end
end
