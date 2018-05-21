class Game < ApplicationRecord
  belongs_to :tournament
  belongs_to :first_team, class_name: :Team, foreign_key: :first_team_id
  belongs_to :second_team, class_name: :Team, foreign_key: :second_team_id
  has_many :bets, dependent: :destroy
  validates :tournament, uniqueness: { scope: [:first_team, :second_team, :date], message: ' - This game already exist in our database.'}
  validates :first_team, :second_team, :date, :tournament, presence: true
  validate :check_first_and_second_team, on: :create


  def self.by_team(team)
    where("first_team_id = :team_id OR second_team_id = :team_id", team_id: team.id)
  end

  def check_first_and_second_team
    if first_team == second_team
     errors.add(:second_team_id, "can't be the same as first team.")
   end
  end
end
