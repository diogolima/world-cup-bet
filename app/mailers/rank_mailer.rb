class RankMailer < ApplicationMailer

  def rank_pdf(all_rank, tournament, user)
    @all_rank = all_rank
    @tournament = tournament
    mail(to: user.email, subject: 'Rank for '+@tournament.name) do |format|
      format.html
      format.pdf do
        attachments['RankTournament.pdf'] = WickedPdf.new.pdf_from_string(
          render_to_string(pdf: 'RankTournament', template: 'rank_mailer/rank_pdf.html.erb')
        )
      end
    end
  end
end
