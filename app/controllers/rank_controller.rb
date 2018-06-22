class RankController < ApplicationController
  before_action :set_tournament_rank
  before_action only: [:send_pdf] {check_admin rank_url(tournament_id: params[:tournament_id])}
  before_action :tournament_rank, only: [:index, :send_pdf]
  before_action only: [:send_pdf] {Rank.rank_mailer @tournament}
  before_action :authenticate_user!
  before_action :set_round, only: [:index]

  def index
  end

  def send_pdf
    respond_to do |format|
      format.html { redirect_to rank_url(tournament_id: params[:tournament_id]), notice: 'Email sent for all users'}
    end
  end

  def scored_bets
    games_ids = Bet.where(user_id: params[:user_id]).where('bet_score >= ?', 0).pluck(:game_id)
    @games = Game.tournament_round(params[:tournament_id], params[:round]).where(id: games_ids).where('score_first_team >= ? AND score_second_team >= ?', 0, 0).order(:date)
    @bets = Bet.where(user_id: params[:user_id]).where(game_id: @games.ids)
    @user = User.find(params[:user_id])
    if @bets.blank?
      respond_to do |format|
        format.html { redirect_to rank_url(tournament_id: params[:tournament_id]), alert: 'This user doesn\'t have bets for this tournament or no game has happened yet.' }
      end
    end
  end

  private
  def set_tournament_rank
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_round
    @rounds = Game.rounds(params[:tournament_id])
  end

  def tournament_rank
    @all_rank = Rank.generate_rank(params[:tournament_id], params[:round])
  end
end
