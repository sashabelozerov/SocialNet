class ChangeMessages2 < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.remove :user_id_target
      t.integer :target_id
    end
  end

  def self.down
    change_table :messages do |t|
      t.remove :target_id
      t.integer :user_id_target
    end
  end
end
