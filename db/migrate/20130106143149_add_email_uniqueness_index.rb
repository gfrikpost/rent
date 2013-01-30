class AddEmailUniquenessIndex < ActiveRecord::Migration
  def change
    add_index :users, :email, :unique => true, :length => 100
  end


end
