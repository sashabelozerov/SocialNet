class AddStatusToFriendship < ActiveRecord::Migration
  def self.up
    change_table :friendships do |t|
      t.string :status
    end
  end

  def self.down
    change_table :friendships do |t|
      t.string :status
    end
  end
end
