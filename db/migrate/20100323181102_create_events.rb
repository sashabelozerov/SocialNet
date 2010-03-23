class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :events
  end
end
