class AddAcceptedToEventUser < ActiveRecord::Migration
  def self.up
    change_table :event_users do |t|
      t.integer :accepted
    end
  end

  def self.down
    change_table :event_users do |t|
      t.remove :accepted
    end
  end
end
