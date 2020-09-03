class AddAverageToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :average_rating, :float, default: 0.0, null: false
  end
end
