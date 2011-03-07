class CreateFeaturedItems < ActiveRecord::Migration
  def self.up
    create_table :featured_items do |t|
      t.integer :product_id
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
    add_index :featured_items, :product_id
    add_index :featured_items, :starts_at
   # CREATE INDEX part_of_name ON customer (name(10));
    #execute('CREATE INDEX featured_items_starts_at_ten ON featured_items (starts_at(10));')

  end

  def self.down
    drop_table :featured_items
  end
end
