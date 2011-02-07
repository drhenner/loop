class AddColorIdToVariants < ActiveRecord::Migration
  def self.up
    add_column :variants, :color_id, :integer

    add_index :variants, :color_id
  end

  def self.down
    remove_column :variants, :color_id
  end
end
