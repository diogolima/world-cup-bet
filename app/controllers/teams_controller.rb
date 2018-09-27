class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @teams = Team.all
  end

  def show
    @games = Game.where(first_team_id: @team.id).or(Game.where(second_team_id: @team.id))
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to @team, notice: 'Team was successfully created'
    else
      render :new
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully destroyed.' 
  end

  private
  def team_params
    params.require(:team).permit(:name, :image)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
