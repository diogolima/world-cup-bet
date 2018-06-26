require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "Check if the first team is the same of the second team in a game" do
    game = Game.first
    isTheSame = game.check_first_and_second_team
    assert isTheSame.to_s, "false"
  end

  test "Get game by tournament/round - 1 game in the round" do
    games = Game.tournament_round(Tournament.first, 1)
    assert games.count, 1
  end

  test "Get game by tournament/round - no games in the round" do
    games = Game.tournament_round(Tournament.first, 2)
    assert games.count, 0
  end

  test "Get game by tournament/round - 2 games in the round" do
    games = Game.tournament_round(Tournament.second, 1)
    assert games.count, 2
  end

  test "Get the rounds of a tournament" do
    tournament = Tournament.first.games.count > 1? Tournament.first : Tournament.second
    rounds = Game.rounds(tournament)
    assert rounds.count, 2
    assert rounds[0], 1
    assert rounds[1], 2
  end

end
