class AddDestroyedToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :is_destroyed, :boolean
  end
end
