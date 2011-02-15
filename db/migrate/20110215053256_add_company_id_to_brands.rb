class AddCompanyIdToBrands < ActiveRecord::Migration
  def self.up
    add_column :brands, :company_id, :integer

    add_index :brands, :company_id
  end

  def self.down
    remove_column :brands, :company_id
  end
end
