class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :user, uniqueness: { scope: [:game], message: ' - You can do only one bet per game.'}
end
