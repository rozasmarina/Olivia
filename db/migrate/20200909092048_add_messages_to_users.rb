class AddMessagesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :message_angels, :text
    add_column :users, :message_near_users, :text
    add_column :users, :message_authorities, :text
  end
end
