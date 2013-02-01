class CreateUserposts < ActiveRecord::Migration
  def change
    create_table :userposts do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :userposts, :user_id
    add_index :userposts, :created_at
  end
end
