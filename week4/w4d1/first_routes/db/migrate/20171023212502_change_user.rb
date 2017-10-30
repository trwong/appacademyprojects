class ChangeUser < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :email
    rename_column :users, :name, :username

    add_index :users, :username, unique: true
  end

  def down
    add_column :users, :email, :string
    rename_column :users, :username, :name
  end
end
