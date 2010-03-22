class ChangeMessages < ActiveRecord::Migration
  def self.up
	change_table :messages do |t|
		t.remove :messageable_id, :messageable_type
		t.remove :author_id
		t.integer :user_id
		t.integer :user_id_target
	end
  end

  def self.down
	change_table :messages do |t|
		t.references :messageable, :polymorphic => true
		t.integer :author_id
		t.remove :user_id, :user_id_target
	end
  end
end
