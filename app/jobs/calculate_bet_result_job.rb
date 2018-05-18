class CalculateBetResultJob < ApplicationJob
  queue_as :default

  def perform(game)
    bets = Bet.all
    bets.each do |bet|
      bet.bet_score = 0
      if bet.first_team_score == game.score_first_team
        bet.bet_score = bet.bet_score + 3
      end
      if bet.second_team_score == game.score_second_team
        bet.bet_score = bet.bet_score + 3
      end
      # - Entire score correct
      if bet.bet_score == 6
        bet.bet_score = 20
      # - Got the correct winner or tie + the score of one of the teams
      elsif (((game.score_first_team > game.score_second_team) && (bet.first_team_score > bet.second_team_score)) || ((game.score_first_team < game.score_second_team) && (bet.first_team_score < bet.second_team_score)) || ((game.score_first_team == game.score_second_team) && (bet.first_team_score == bet.second_team_score)))
          bet.bet_score = bet.bet_score + 12
      end
      bet.save
    end
  end
end
