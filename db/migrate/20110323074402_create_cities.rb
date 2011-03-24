class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string  :name,      :null => false
      t.integer :state_id,  :null => false
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end

    add_column :companies, :city_id, :integer

    add_index :companies, :city_id
    add_index :cities,    :state_id
  end

  def self.down
    remove_column :companies, :city_id
    drop_table :cities
  end
end
