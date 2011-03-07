class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :label
      t.text :brief_description
      t.text :full_description

      t.timestamps
    end
    execute('CREATE INDEX companies_name_ten ON companies (name(9));')
  end

  def self.down
    drop_table :companies
  end
end
