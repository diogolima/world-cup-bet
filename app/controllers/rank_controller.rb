class RankController < ApplicationController
  before_action :set_tournament_rank

  def index
    users_ids = Bet.distinct.pluck(:user_id)
    games_ids = Game.order(:date).where(tournament_id: params[:tournament_id]).ids
    @all_rank = []
    users_ids.each do |id|
      user = User.where(id: id)
      @all_rank.push(
        name: user.first.name,
        user_id: user.first.id,
        score: Bet.where(user_id: id).where(game_id: games_ids).sum(:bet_score)
      )
    end
    @all_rank = @all_rank.sort_by {|user| user[:score]}.reverse!
  end

  def scored_bets
    games_ids = Bet.where(user_id: params[:user_id]).where('bet_score >= ?', 0).pluck(:game_id)
    @games = Game.where(id: games_ids).where(tournament_id: params[:tournament_id]).where('score_first_team >= ? AND score_second_team >= ?', 0, 0).order(:date)
    @bets = Bet.where(user_id: params[:user_id]).where(game_id: @games.ids)
    if @bets.blank?
      respond_to do |format|
        format.html { redirect_to rank_url(tournament_id: params[:tournament_id]), alert: 'This user doesn\'t have bets for this tournament' }
      end
    end
  end

  private
  def set_tournament_rank
    @tournament = Tournament.find(params[:tournament_id])
  end
end
