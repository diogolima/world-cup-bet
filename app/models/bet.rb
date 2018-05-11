class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :user, uniqueness: { scope: [:game], message: ' - You can do only one bet per game.'}
  validates :first_team_score, :second_team_score, inclusion: { in: 0..20 }
end
