require 'rails_helper'
require 'spec_helper'

RSpec.describe TournamentsController, type: :controller do
  before(:each) do
    sign_in create(:user)
  end
  describe 'GET #index' do
    it 'has a 200 status' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'GET all tournaments' do
      tournaments
      get :index
      expect(assigns[:tournaments]).to eq(Tournament.all)
    end
  end

  describe 'POST #create' do
    it 'has a 302 status' do
      get :create, :params => {tournament: {name: 'World cup 2014 - Brazil', description: 'Best ever.'}}
      expect(response.status).to eq(302)
    end

    it 'Create a tournament' do
      tournaments
      num_tournaments = Tournament.all.count
      get :create, :params => {tournament: {name: 'World cup 2014 - Brazil', description: 'Best ever.'}}
      expect(assigns[:tournament]).to eq(Tournament.last)
      expect(Tournament.all.count).to eq(num_tournaments+1)
    end
  end
end
