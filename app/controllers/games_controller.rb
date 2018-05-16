class GamesController < ApplicationController
before_action :set_teams, only: [:new, :create, :edit, :update]
before_action :set_game, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, except: [:show, :index]


  def index
    @games = Game.all if @games.blank?
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully created.' }
    end
  end

  def per_tournament
    @games = Game.find_by(tournament_id: params[:tournament_id])
    respond_to do |format|
      if @games.blank?
        format.html { redirect_to root_path, notice: 'This tournament does not have games.' }
      else
        format.html { redirect_to games_path, notice: 'This tournament does not have games.' }
      end
    end
  end

  private
  def game_params
    params.require(:game).permit(:date, :first_team_id, :second_team_id, :score_first_team, :score_second_team, :tournament_id)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_teams
    @teams = Team.all
  end
end
