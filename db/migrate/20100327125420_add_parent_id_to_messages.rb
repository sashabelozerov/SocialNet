class AddParentIdToMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.integer :parent_id
    end
  end

  def self.down
    change_table :messages do |t|
      t.remove :parent_id
    end
  end
end
