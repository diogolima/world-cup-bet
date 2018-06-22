class Rank

  def self.rank_mailer(tournament)
    Bet.bet_user_per_tournament(tournament.id).each do |user|
      mail = RankMailer.rank_pdf(@all_rank, tournament, user).deliver_later
    end
  end

  def self.generate_rank(tournament_id, round)
    users_ids = Bet.distinct.pluck(:user_id)
    games_ids = Game.tournament_round(tournament_id,round).ids
    @all_rank = []
    users_ids.each do |id|
      user = User.find(id)
      @all_rank.push(
        name: user.name,
        user_id: user.id,
        score: Bet.where(user_id: id).where(game_id: games_ids).sum(:bet_score)
      )
    end
    @all_rank = @all_rank.sort_by {|user| user[:score]}.reverse!
  end
end
