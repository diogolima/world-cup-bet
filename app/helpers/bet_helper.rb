module BetHelper

  def rank_mailer
    Bet.bet_user_per_tournament(@tournament.id).each do |user|
      mail = RankMailer.rank_pdf(@all_rank, @tournament, user).deliver_later
    end
  end
end
