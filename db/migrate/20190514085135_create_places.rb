class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.decimal :longitude, :precision => 10, :scale => 7
      t.decimal :latitude, :precision => 10, :scale => 7

      t.timestamps
    end
  end
end
