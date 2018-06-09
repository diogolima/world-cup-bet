class RankController < ApplicationController
  include RankHelper
  before_action :set_tournament_rank
  before_action :generate_rank, only: [:index, :send_pdf]
  before_action only: [:send_pdf] {check_admin rank_url(tournament_id: params[:tournament_id])}
  before_action :rank_mailer, only: [:send_pdf]
  before_action :authenticate_user!

  def index
  end

  def send_pdf
    respond_to do |format|
      format.html { redirect_to rank_url(tournament_id: params[:tournament_id]), notice: 'Email sent for all users'}
    end
  end

  def scored_bets
    games_ids = Bet.where(user_id: params[:user_id]).where('bet_score >= ?', 0).pluck(:game_id)
    @games = Game.where(id: games_ids).where(tournament_id: params[:tournament_id]).where('score_first_team >= ? AND score_second_team >= ?', 0, 0).order(:date)
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

end
