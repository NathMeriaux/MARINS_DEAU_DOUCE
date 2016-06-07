class RemoveRemoteAttributesToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remote_first_name
    remove_column :users, :remote_last_name
    remove_column :users, :remote_picture
  end
end
