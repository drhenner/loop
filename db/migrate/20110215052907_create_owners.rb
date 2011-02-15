class CreateOwners < ActiveRecord::Migration
  def self.up
    create_table :owners do |t|
      t.integer :company_id
      t.string  :name
      t.text    :brief_description
      t.text    :full_description

      t.timestamps
    end

    add_index :owners, :company_id
  end

  def self.down
    drop_table :owners
  end
end
