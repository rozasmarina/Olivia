class AddDestroyedToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :is_disabled, :boolean, default: false
  end
end
