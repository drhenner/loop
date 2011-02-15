class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.integer :user_id
      t.decimal :shoe_size
      t.decimal :waist
      t.integer :pant_length
      t.integer :dress_size
      t.string :shirt_size

      t.timestamps
    end
    add_index :measurements, :user_id
  end

  def self.down
    drop_table :measurements
  end
end
