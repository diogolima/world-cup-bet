class RankController < ApplicationController
  include BetHelper
  before_action :set_tournament_rank
  before_action :set_rank, only: [:index, :send_pdf]
  before_action :check_admin, only: [:send_pdf]
  before_action :rank_mailer, only: [:send_pdf]

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

  def set_rank
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

  def check_admin
    (current_user && current_user.admin)?
      true : respond_to do |format| format.html { redirect_to rank_url(tournament_id: params[:tournament_id]), alert: 'This action is only allowed for the admin.' }
    end
  end
end
