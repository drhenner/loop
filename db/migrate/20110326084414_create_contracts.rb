class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :name
      t.integer :brand_id,          :null => false
      t.decimal :flash_percent,     :null => false,             :precision => 8, :scale => 2
      t.decimal :store_percent,     :null => false,             :precision => 8, :scale => 2
      t.date :start_date,           :null => false
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
