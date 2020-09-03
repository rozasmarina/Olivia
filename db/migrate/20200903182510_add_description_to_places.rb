class AddDescriptionToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :description, :text
  end
end
