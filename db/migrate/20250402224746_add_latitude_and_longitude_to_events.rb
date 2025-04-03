class AddLatitudeAndLongitudeToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :latitude, :decimal, precision: 15, scale: 10
    add_column :events, :longitude, :decimal, precision: 15, scale: 10
  end
end
