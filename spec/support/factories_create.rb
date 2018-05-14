def teams
  name = "Brazil", "Russia", "Germany", "Italy"
  name.each do |team|
    create(:team, name: team)
  end
end

def tournaments
  name = "World Cup 2018 - Russia", "World cup Qatar 2022"
  name.each do |name|
    create(:tournament, name: name)
  end
end

def games
  teams
  tournaments
  teams = Team.all
  all_tournaments = Tournament.all
  all_tournaments.each do |tournament|
    teams.each.with_index do |team, index|
      i =1+index
      (teams.count-i).times do
        create(:game, first_team: team, second_team: teams[i], tournament: tournament)
        i=i+1
      end
    end
  end
  # 0,1/0,2/0,3/1,2/1,3/2,3
end

def bets(all_games)
  all_games.each do |game|
    create(:bet, first_team_score: 1, second_team_score: 0, game_id: game.id, user_id: User.first.id)
  end
end
