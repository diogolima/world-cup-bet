module ChargesHelper

  def user_payed(tournament_id)
    current_user && current_user.charge.find_by(tournament_id: tournament_id)
  end
end
