class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action only: [:index] {Tournament.tournament_pick params[:tournament]}
  before_action only: [:edit, :update] {Bet.bet_before_game @bet.game.date}

  def index
    @bets = current_user.get_bets(params[:tournament])
    @tournament_missing_bets = current_user.missing_bets_tournament(@tournaments)
  end

  def show
  end

  def edit
  end

  def new
    @bet = current_user.bets.build
  end

  def missing_bets
    @bets = current_user.bets.pluck(:game_id)
    games = Game.all.where(tournament_id: params[:tournament][:id]).where("date > ? ", Time.now.utc - 2.hour).order(:date).where.not(id: @bets)
    @all_bets = Bet.init_bet(games, current_user)
    if @all_bets.empty?
      respond_to do |format|
        format.html { redirect_to bets_url, notice: 'All bets for this tournament are ready.'}
      end
    end
  end

  def create_bets
    byebug
    params[:bets].each do |bet|
      if Bet.valid_bet(bet)
        Bet.save_bet(bet, current_user)
      end
    end
    respond_to do |format|
      format.html { redirect_to bets_url, notice: 'Filled bets were created.' }
    end
  end

  def update
    respond_to do |format|
      if @bet.update(bet_params)
        format.html { redirect_to bets_url, notice: 'Bet was successfully updated'}
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @bet = current_user.bets.build(bet_params)
    respond_to do |format|
      if @bet.save
        format.html { redirect_to @bet, notice: 'Bet was successfully created.' }
        format.json { render :show, status: :created, location: @bet }
      else
        format.html { render :new }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  private
  def set_bet
    @bet = Bet.find(params[:id])
  end

  def bet_params
    params.require(:bet).permit(:game_id, :first_team_score, :second_team_score)
  end
end
