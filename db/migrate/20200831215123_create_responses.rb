class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.references :review, null: false, foreign_key: true
      t.text :response
      t.timestamps
    end
  end
end
