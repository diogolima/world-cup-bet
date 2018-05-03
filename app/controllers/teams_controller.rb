class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
    end
  end

  private
  def team_params
    params.require(:team).permit(:name, :image)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
