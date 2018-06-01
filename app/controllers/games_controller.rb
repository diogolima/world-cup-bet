class GamesController < ApplicationController
before_action :set_teams, only: [:new, :create, :edit, :update]
before_action :set_game, only: [:show, :edit, :update, :destroy]
before_action :set_round, only: [:per_tournament, :round]
before_action :authenticate_user!, except: [:show, :index]
after_action :calculate_result, only: [:update, :create]

  def index
    @games = Game.all.order(:date) if @games.blank?
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
    @game = Game.new(tournament_id: params[:tournament_id])
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
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
    end
  end

  def per_tournament
    @games = Game.order(:date).where(tournament_id: params[:tournament_id])
    respond_to do |format|
      if @games.blank?
        if !current_user.admin
          format.html { redirect_to root_path, notice: 'This tournament does not have games.' }
        else
          format.html { redirect_to new_game_url tournament_id: params[:tournament_id]}
        end
      else
        format.html { render action: :index }
      end
    end
  end

  def round
    @games = Game.order(:date).where(tournament_id: params[:tournament_id], round: params[:round])
    respond_to do |format|
      format.html { render action: :index }
    end
  end

  private
  def game_params
    params.require(:game).permit(:date, :first_team_id, :second_team_id, :score_first_team, :score_second_team, :round, :tournament_id)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_teams
    @teams = Team.all
  end

  def set_round
    @rounds = Game.where(tournament_id: params[:tournament_id]).order(:round).distinct(:round).pluck(:round)
  end

  def calculate_result
    if !@game.score_first_team.blank? && !@game.score_second_team.blank?
      CalculateBetResultJob.perform_now @game
    end
  end
end
