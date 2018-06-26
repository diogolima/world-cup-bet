class Tournament < ApplicationRecord
  has_many :games, dependent: :destroy
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_attached_file :image, styles: { medium: "320x240#", thumb: "110x80#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.tournament_pick(tournament = nil)
    @tournament_pick = tournament.blank? ? 'All bets' : 'All bets - '+Tournament.where(id: tournament[:id]).first.name+' tournament.'
    @no_bets_tournament = tournament.blank? ? 'You don\'t have any bet yet!' : 'You don\'t have bets for '+Tournament.where(id: tournament[:id]).first.name+' tournament.'
  end

end
