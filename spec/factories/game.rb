FactoryBot.define do
  #
  factory :game do
    first_team_id 1
    second_team_id 2
    tournament_id 1
    date DateTime.now + 1.month
  end

end
