class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :name
      t.integer :brand_id
      t.decimal :flash_percent
      t.decimal :store_percent
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
