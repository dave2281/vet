class ChangeRoleDefaultInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :role, 'member'
    change_column_null :users, :role, false
  end
end
