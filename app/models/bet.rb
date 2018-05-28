class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :user, uniqueness: { scope: [:game], message: ' - You can do only one bet per game.'}
  validates :first_team_score, :second_team_score, inclusion: { in: 0..20 }

  def self.bet_user_per_tournament(tournament)
    User.where(id: self.where(game_id: Game.where(tournament_id: tournament).ids).distinct(:user_id).pluck(:user_id))
  end
end
