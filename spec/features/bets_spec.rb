require 'rails_helper'
require 'spec_helper'


RSpec.feature 'Bets - ' do
  before(:each) do
    games
    sign_in
    bets(Game.all)
  end
  scenario 'Try edit a bet' do
    @bets = Bet.all
    game = Game.first
    game.date = DateTime.now - 1.month
    game.save
    visit '/bets'
    ref =  "a[href=\"/bets/"+Bet.first.id.to_s+"/edit\"]"
    find(ref).click
    expect(page.text).to have_content 'You can\'t change your bet on game day.'
  end
end
