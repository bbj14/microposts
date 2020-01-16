class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :can_login, :boolean, default: true, null: false
    add_column :users, :can_post, :boolean, default: true, null: false
    add_column :users, :can_follow, :boolean, default: true, null: false
  end
end
