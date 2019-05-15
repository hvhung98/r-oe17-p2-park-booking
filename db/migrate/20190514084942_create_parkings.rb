class CreateParkings < ActiveRecord::Migration[5.2]
  def change
    create_table :parkings do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :waiting_time
      t.text :description
      t.integer :total_position
      t.integer :avail_position
      t.decimal :longitude, :precision => 10, :scale => 7
      t.decimal :latitude, :precision => 10, :scale => 7
      t.string :status, default: "Mở cửa"
      t.string :address
      t.time :time_open
      t.time :time_close
      t.integer :price
      t.timestamps
    end
  end
end
