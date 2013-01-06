class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :users, :email, :unique => true, :length => 100
  end

  def down
    remove_index :users, :email
  end
end
