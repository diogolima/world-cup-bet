class TournamentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      render :edit
    end
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.'
  end

  private
  def tournament_params
    params.require(:tournament).permit(:name, :description, :image)
  end

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

end
