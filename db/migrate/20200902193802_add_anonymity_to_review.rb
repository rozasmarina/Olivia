class AddAnonymityToReview < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :is_anonymous?, :boolean, default: false, null: false
  end
end
