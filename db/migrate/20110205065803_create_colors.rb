class CreateColors < ActiveRecord::Migration
  def self.up
    create_table :colors do |t|
      t.string :name, :limit => 80, :null => false
      t.string :css_color, :limit => 20
      t.boolean :searchable, :default => true
    end
  end

  def self.down
    drop_table :colors
  end
end
