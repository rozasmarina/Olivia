class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.references :user, null: false, foreign_key: true
      t.references :owner, foreign_key: { to_table: 'users' }
      t.string :name
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
