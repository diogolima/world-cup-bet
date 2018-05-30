class AddRoundToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :round, :integer
  end
end
