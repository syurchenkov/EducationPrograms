class AddIndexToUserGroups < ActiveRecord::Migration[5.1]
  def change
    add_index :user_groups, [:user_id, :group_id], name: 'index_user_groups_user_id_group_id', unique: true
  end
end
