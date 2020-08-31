class CreateAngels < ActiveRecord::Migration[6.0]
  def change
    create_table :angels do |t|
      t.string :first_name
      t.string :email
      t.string :phone_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
