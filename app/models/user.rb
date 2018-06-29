class User < ApplicationRecord
  validates :name, presence: true
  has_many :bets, dependent: :destroy
  has_many :charge, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2, :linkedin, :twitter]

  def self.create_from_provider_data(auth)
    if self.where(email: auth.info.email).exists?
      login_user = self.where(email: auth.info.email).first
      login_user.provider = auth.provider
      login_user.uid = auth.uid
    else
      login_user = self.create do |user|
         user.provider = auth.provider
         user.uid = auth.uid
         user.name = auth.info.name
         user.email = auth.info.email
      end
    end
    login_user
  end

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

  def get_bets(tournament=nil)
    @bets = self.bets
    if tournament && tournament[:id]
      @bets = @bets.where(game_id: Game.where(tournament_id: tournament[:id]))
    end
    @bets = @bets.sort_by{|bet| bet.game.date}
  end

end
