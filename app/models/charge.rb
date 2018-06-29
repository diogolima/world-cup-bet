class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :tournament
  validates :user, uniqueness: { scope: [:tournament], message: ' - You can pay only once per tournament.'}
  scope :already_payed, -> (user_id, tournament_id) { where(user_id: user_id, tournament_id: tournament_id )}

  def self.user_pay_bet_in_tournament(user, tournament, charge)
    if charge.paid && charge.status == "succeeded"
      self.new(amount: charge.amount/100, user: user, tournament: tournament).save
    end
  end
end
