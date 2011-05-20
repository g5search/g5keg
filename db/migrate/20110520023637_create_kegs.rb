class CreateKegs < ActiveRecord::Migration
  def self.up
    create_table :kegs do |t|
      t.integer :beer_id
      t.date :tapped
      t.date :kicked
      t.decimal :starting_weight, :precision => 8, :scale => 2
      t.decimal :ending_weight, :precision => 8, :scale => 2
      t.timestamps
    end

    add_index :kegs, :beer_id
    add_index :kegs, [:tapped, :kicked]
  end

  def self.down
    drop_table :kegs
  end
end
