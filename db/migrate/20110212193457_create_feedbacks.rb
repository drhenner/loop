class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :type
      t.string :title
      t.string :name
      t.text    :content
      t.string :email
      t.string :website
      t.string :user_ip
      t.string :permalink
      t.string :user_agent
      t.string :referrer

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
