class Logo < ActiveRecord::Migration
  def self.up
    add_column :beers, :logo_path, :string
  end

  def self.down
    remove_column :beers, :logo_path
  end
end