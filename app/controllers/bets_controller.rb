class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_action :allow_modify, only: [:edit, :update]
  before_action :authenticate_user!
  before_action only: [:index] {Tournament.tournament_pick params[:tournament]}
  before_action :can_see_bet, only: [:show_bet_from_users]
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

  def show_bet_from_users
    @game = Game.find(params[:game_id])
    @bets = Bet.where(game_id: @game.id)
  end

  private
  def set_bet
    @bet = Bet.find(params[:id])
  end

  def bet_params
    params.require(:bet).permit(:game_id, :first_team_score, :second_team_score)
  end

  def can_see_bet
    if !Bet.bet_on_time(Game.find(params[:game_id]).date)
        redirect_to games_per_tournament_path tournament_id: params[:tournament_id], alert: "You can\'t see all the bets yet - bet still can be modify."
    end
  end
  def allow_modify
   if Bet.bet_on_time(@bet.game.date)
     respond_to do |format|
       format.html { redirect_to bets_url, alert: 'You can\'t change your bet with less than one hour of the game.'}
     end
   end
  end
end
