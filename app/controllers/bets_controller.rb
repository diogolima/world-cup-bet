class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_action :set_tournament, only: [:index, :find]

  def index
    @bets = current_user.bets
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
    games = Game.all.where(tournament_id: params[:tournament][:id])
    @bets = current_user.bets.pluck(:game_id)
    games = games.where.not(id: @bets)
    @all_bets = init_bet(games)
    if @all_bets.empty?
      respond_to do |format|
        format.html { redirect_to bets_url, notice: 'All bets for this tournament are ready.'}
      end
    end
  end

  def create_bets
    params[:bets].each do |bet|
      if valid_bet(bet)
        @bet = current_user.bets.build(
          first_team_score: bet[:first_team_score].to_i,
          second_team_score: bet[:second_team_score].to_i,
          game_id: bet[:game_id]
        )
        @bet.save
      end
    end
    respond_to do |format|
      format.html { redirect_to bets_url, notice: 'Filled bets were created.' }
    end
  end

  def update
    respond_to do |format|
      if @bet.update(bet_params)
        format.html { redirect_to @bet, notice: 'Bet was successfully created'}
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

  def set_tournament
    @tournaments = Tournament.find(Game.all.distinct.pluck(:tournament_id))
  end

  def bet_params
    params.require(:bet).permit(:user_id, :game_id, :first_team_score, :second_team_score)
  end

  def valid_bet(bet)
    game = Game.find(bet[:game_id])
    (!bet[:first_team_score].blank? | !bet[:second_team_score].blank?)&&(game.first_team.id == bet[:first_team_id].to_i && game.second_team.id == bet[:second_team_id].to_i)
  end

  def init_bet(games)
    @all_bets = []
    if games.nil? || games.count > 0
      games.each do |game|
        @all_bets.push(Bet.new(game_id: game.id, user_id: current_user.id))
      end
    end
    @all_bets
  end

end
