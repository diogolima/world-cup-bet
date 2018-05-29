require 'rails_helper'
require 'spec_helper'



RSpec.describe BetsController, type: :controller do
  before(:each) do
    games
    sign_in create(:user)
  end
  describe 'GET #index' do
    it 'has a 200 status, get missing bets' do
      bets([Game.first])
      get :index
      expect(response.status).to eq(200)
    end
    it 'Get bets made and all tournaments missing bets' do
      bets([Game.first])
      get :index
      expect(response.status).to eq(200)
      expect(assigns[:bets]).to eq(User.first.bets)
      expect(assigns[:tournament_missing_bets].count).to eq(2)
    end
    it 'Get bets made and one tournaments missing bets' do
      bets(Game.all.where(tournament_id: Tournament.first))
      get :index
      expect(response.status).to eq(200)
      expect(assigns[:bets]).to eq(User.first.bets)
      expect(assigns[:tournament_missing_bets].count).to eq(1)
    end
    it 'Get bets made and empty tournaments missing bets' do
      bets(Game.all)
      get :index
      expect(response.status).to eq(200)
      expect(assigns[:bets]).to eq(User.first.get_bets)
      expect(assigns[:tournament_missing_bets]).to eq([])
    end
  end

  describe 'POST #missing_bets' do
    it 'has a 200 status' do
      bets([Game.first])
      post :missing_bets, :params => {tournament: {id: Tournament.first}}
      expect(response.status).to eq(200)
    end
    it 'has all missing bets for a tournament' do
      bets([Game.first])
      user_bets = User.first.bets
      post :missing_bets, :params => {tournament: {id: Tournament.first}}
      expect(assigns[:bets]).to eq([user_bets.first.game.id])
      expect(assigns[:all_bets].count).to eq(Game.all.where(tournament_id: Tournament.first).count-user_bets.count)
    end
  end

  describe 'POST create_bets' do
    it 'has a 302 status - redirect to index' do
      post :create_bets, :params => {bets: [game_id: Game.first.id,
                                            first_team_id: Game.first.first_team_id,
                                            second_team_id: Game.first.second_team_id,
                                            user_id: User.first.id]}
      expect(response.status).to eq(302)
    end
    it 'Create a bet' do
      num_bets = User.first.bets.blank? ? 0 : User.first.bets.count
      post :create_bets, :params => {bets: [game_id: Game.first.id,
                                            first_team_id: Game.first.first_team_id,
                                            second_team_id: Game.first.second_team_id,
                                            first_team_score: 1,
                                            second_team_score: 0,
                                            user_id: User.first.id]}
      expect(response.status).to eq(302)
      expect(User.first.bets.count).to eq(num_bets+1)
    end
  end

  describe 'GET edit_bet' do
    it 'has a 302 staus - redirect to index' do
      game = Game.first
      game.date = DateTime.now
      game.save
      bets(Game.all)
      get :edit, :params => {id: Bet.find_by(game_id: game.id).id}
      expect(response.status).to eq(302)
    end
  end
end
