class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :label
      t.text :brief_description
      t.text :full_description

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
