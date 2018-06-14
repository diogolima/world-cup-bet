class CalculateBetResultJob < ApplicationJob
  queue_as :default

  def perform(game)
    bets = Bet.where(game_id: game.id)
    bets.each do |bet|
      bet.bet_score = 0
      if bet.first_team_score == game.score_first_team && bet.second_team_score == game.score_second_team
        bet.bet_score = 25
      # - Got the correct winner or tie + the score of one of the teams
      elsif (game.score_first_team > game.score_second_team && bet.first_team_score > bet.second_team_score)
        bet.bet_score = calculate_points(game.score_first_team, game.score_second_team, bet.first_team_score, bet.second_team_score)
      elsif  (game.score_first_team < game.score_second_team && bet.first_team_score < bet.second_team_score)
        bet.bet_score = calculate_points(game.score_second_team, game.score_first_team, bet.second_team_score, bet.first_team_score)
      elsif (game.score_first_team == game.score_second_team && bet.first_team_score == bet.second_team_score)
        bet.bet_score = 18
      end
      bet.save
    end
  end

  def calculate_points(game1, game2, bet1, bet2)
    bet_score = 10
    #Correct goals of the winner
    if game1 == bet1
      bet_score += 5
    #Correct goals of the loser
    elsif game2 == bet2
      bet_score += 2
    #Correct goal difference
  elsif (game1 - game2).abs == (bet1 - bet2).abs
      bet_score += 8
    else
      bet_score
    end
  end
end
