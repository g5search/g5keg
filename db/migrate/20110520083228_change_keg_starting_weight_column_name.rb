class ChangeKegStartingWeightColumnName < ActiveRecord::Migration
  def self.up
    rename_column :kegs, :starting_weight, :current_weight
  end

  def self.down
    rename_column :kegs, :current_weight, :starting_weight
  end
end
