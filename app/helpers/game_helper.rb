module GameHelper

  def tournament_name
    if !params[:tournament_id].blank?
      tournament = Tournament.where(id: params[:tournament_id]).first
      " - #{tournament.name} " if !tournament.blank?
    elsif !@games.blank?
        " - #{@games.first.tournament.name}"
    else
        " - All tournaments"
    end
  end
end
