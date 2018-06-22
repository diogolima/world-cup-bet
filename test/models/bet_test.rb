require 'test_helper'

class BetTest < ActiveSupport::TestCase
  test "Get users of a tournament" do
    user = Bet.bet_user_per_tournament(Tournament.first.id)
    assert user.count, 1
    assert user.first.id, User.first.id
  end

  test "Valid bet" do
    bet = Bet.first
    is_valid = Bet.valid_bet({game_id: bet.game_id, first_team_score: bet.first_team_score, second_team_score: bet.second_team_score, first_team_id: bet.game.first_team.id, second_team_id: bet.game.second_team.id})
    assert is_valid.to_s, 'true'
  end

  test "Invalid bet" do
    bet = Bet.third
    is_valid = Bet.valid_bet({game_id: bet.game_id, first_team_score: bet.first_team_score, second_team_score: bet.second_team_score, first_team_id: bet.game.first_team.id, second_team_id: bet.game.second_team.id})
    assert is_valid.to_s, 'false'
  end

  test "save bet" do
    bets = User.first.bets.count
    Bet.save_bet({first_team_score: 2, second_team_score: 0, game_id: Game.last.id}, User.first)
    assert User.first.bets.count, bets+1
  end

  test "Bet on time, more than one hour of the game" do
    is_valid = Bet.bet_on_time(DateTime.now - 2.hour)
    assert is_valid.to_s, 'true'
  end

  test "Not valid bet, it has just one hour of the game" do
    is_valid = Bet.bet_on_time(DateTime.now - 1.hour)
    assert is_valid.to_s, 'false'
  end

end
