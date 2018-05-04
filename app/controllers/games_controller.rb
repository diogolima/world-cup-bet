class GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @game = Game.new
    @teams = Team.all
    @tournament = Tournament.all
  end

  def create
    @game = Game.new(game_params)
    @teams = Team.all
    @tournament = Tournament.all
    byebug
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
  end

  private
  def game_params
    params.require(:game).permit(:date, :first_team_id, :second_team_id, :score_first_team, :score_second_team, :tournament_id)
  end
end
