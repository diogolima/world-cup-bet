class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.datetime :date
      t.integer :score_first_team
      t.integer :score_second_team
      t.references :tournament
      t.references :first_team
      t.references :second_team
      t.timestamps
    end

    add_foreign_key :games, :teams, column: :first_team_id, primary_key: :id, on_delete: :cascade
    add_foreign_key :games, :teams, column: :second_team_id, primary_key: :id, on_delete: :cascade
    add_foreign_key :games, :tournaments, column: :tournament_id, primary_key: :id, on_delete: :cascade
  end
end
