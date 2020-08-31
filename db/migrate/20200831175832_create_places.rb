class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end
