class OnTap < ActiveRecord::Migration
  def self.up
    add_column :beers, :on_tap, :boolean, :default => false
    add_index :beers, :on_tap
  end

  def self.down
    remove_column :beers, :on_tap
  end
end
