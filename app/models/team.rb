class Team < ApplicationRecord
  has_many :home_games, class_name: :Game, foreign_key: :first_team_id, dependent: :destroy
  has_many :away_games, class_name: :Game, foreign_key: :second_team_id, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  has_attached_file :image, styles: { medium: "320x240#", thumb: "80x110#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def games
    Game.by_team(self)
  end
end
