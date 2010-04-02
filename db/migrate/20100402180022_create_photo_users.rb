class CreatePhotoUsers < ActiveRecord::Migration
  def self.up
    create_table :photo_users do |t|
      t.integer :user_id
      t.integer :photo_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :photo_users
  end
end
