class AddUniqueIndexToGame < ActiveRecord::Migration[5.1]
  def change
    add_index :games, [:date, :first_team_id, :second_team_id, :tournament_id],
      unique: true, name: 'game_index'
  end
end
