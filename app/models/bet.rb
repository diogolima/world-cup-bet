class Bet < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :user, uniqueness: { scope: [:game], message: ' - You can do only one bet per game.'}
  validates :first_team_score, :second_team_score, inclusion: { in: 0..20 }

  def self.bet_user_per_tournament(tournament)
    User.where(id: self.where(game_id: Game.where(tournament_id: tournament).ids).distinct(:user_id).pluck(:user_id))
  end

  #check for a valid params to create a bet
  def self.valid_bet(bet)
    @game = Game.find(bet[:game_id])
    (!bet[:first_team_score].blank? && !bet[:second_team_score].blank?)&&(@game.first_team.id == bet[:first_team_id].to_i && @game.second_team.id == bet[:second_team_id].to_i && !bet_on_time(@game.date))
  end

  def self.save_bet(bet, current_user)
    @bet = current_user.bets.build(
      first_team_score: bet[:first_team_score].to_i,
      second_team_score: bet[:second_team_score].to_i,
      game_id: bet[:game_id]
    )
    @bet.save
  end

  def self.bet_before_game(game_date)
    if bet_on_time(game_date)
      respond_to do |format|
        format.html { redirect_to bets_url, alert: 'You can\'t change your bet with less than one hour of the game.'}
      end
    end
  end

  def self.bet_on_time(game_date)
    (game_date - 1.hour) <= (Time.now.utc - 3.hour)
  end

  def self.init_bet(games, current_user)
    @all_bets = [ ]
    if !games.nil? || games.count > 0
      games.each do |game|
        @all_bets.push(Bet.new(game_id: game.id, user_id: current_user.id))
      end
    end
    @all_bets
  end

  def self.calculate_result_after_game(game)
    if !game.score_first_team.blank? && !game.score_second_team.blank?
      CalculateBetResultJob.perform_now game
    end
  end
end
