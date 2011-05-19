class Beer < ActiveRecord::Migration
  def self.up
     create_table :beers do |t|
       t.integer :brewery_id
       t.string :name
       t.text :description
       t.integer :ibus
       t.float :alcohol
     end

    create_table :breweries do |t|
      t.string :name
      t.string :link
    end

  end

  def self.down
    drop_table :beers
    drop_table :breweries
  end 
end
