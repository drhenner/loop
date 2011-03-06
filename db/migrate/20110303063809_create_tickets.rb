class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :subject
      t.string :status
      t.text :details
      t.integer :user_id
      t.integer :assigned_to_id
      t.integer :brand_id
      t.string :issue_type
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
