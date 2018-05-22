class User < ApplicationRecord
  validates :name, presence: true
  has_many :bets
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def missing_bets_tournament(all_tournaments)
    @tournament_missing_bets = []
    all_tournaments.each do |tournament|
      games = Game.where(tournament_id: tournament)
      if games.count != self.bets.where(game_id: games.ids).count
        @tournament_missing_bets.push(tournament)
      end
    end
    @tournament_missing_bets
  end

  def get_bets(tournament)
    @bets = self.bets
    if tournament && tournament[:id]
      @bets = @bets.where(game_id: Game.where(tournament_id: tournament[:id]))
    end
    @bets = @bets.sort_by{|bet| bet.game.date}
  end

end
