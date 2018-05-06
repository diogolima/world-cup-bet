class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.integer :first_team_score
      t.integer :second_team_score
      t.integer :bet_score
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
