class AddCompanyIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :company_id, :integer

    add_index :users, :company_id
  end

  def self.down
    remove_column :users, :company_id
  end
end
