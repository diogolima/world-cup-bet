require 'rails_helper'
require 'spec_helper'

RSpec.describe GamesController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end

  describe 'GET #index' do
    it 'has a 200 status' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'GET all games' do
      games
      get :index
      expect(assigns[:games]).to eq(Game.all)
    end
  end

  describe 'POST #create' do
    it 'has a 200 status -- not created' do
      num_games = Game.all.count
      get :create, :params => {game: {first_team_id: 1, second_team_id: 1, tournament_id: 1, date: DateTime.new(2019,02,02)}}
      expect(response.status).to eq(200)
      expect(Game.all.count).to eq(num_games)
    end

    it 'Create a game' do
      games
      num_games = Game.all.count
      get :create, :params => {game: {first_team_id: Team.first.id, second_team_id: Team.last.id, tournament_id: Tournament.last.id, date: DateTime.new(2019,02,02)}}
      expect(assigns[:game]).to eq(Game.last)
      expect(Game.all.count).to eq(num_games+1)
      expect(response.status).to eq(302)
    end
  end

end
