class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true
      t.boolean :is_good?, null: false, default: false
      t.boolean :is_satisfied?, default: false
      t.string :title
      t.text :content
      t.integer :rating

      t.timestamps
    end
  end
end
