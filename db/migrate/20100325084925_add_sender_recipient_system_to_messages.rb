class AddSenderRecipientSystemToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.integer :target_read, :user_read, :target_deleted, :user_deleted
    end
  end

  def self.down
    change_table :messages do |t|
    	t.remove :target_read, :user_read, :target_deleted, :user_deleted
  	end
  end
end
