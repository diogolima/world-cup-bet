# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.destroy_all
Tournament.destroy_all

@world_cup_national_teams = [
  'Russia', 'Egypt', 'Saudi Arabia', 'Uruguay', #Group A -3
  'Portugal', 'Spain', 'Morocco', 'IR Iran', #Group B - 7
  'France', 'Australia', 'Peru', 'Denmark', #Group C - 11
  'Argentina', 'Iceland', 'Croatia', 'Nigeria', #Group D - 15
  'Brazil', 'Switzerland', 'Costa Rica', 'Serbia', #Group E - 19
  'Germany', 'Mexico', 'Sweden', 'Korea Republic', #Group F - 23
  'Belgium', 'Panama', 'Tunisia', 'England', #Group G - 27
  'Poland', 'Senegal', 'Colombia', 'Japan' #Group H - 31
]
@game_order = [
  0,2,1,3,6,7,4,5,8,9,12,13,10,11,14,15,18,19,20,21,16,17,22,23,24,25,26,27,30,31,28,29, #round1
  0,1,4,6,3,2,7,5,11,9,8,10,12,14,16,18,15,13,19,17,24,26,23,21,20,22,27,25,31,29,28,30, #round2
  2,1,3,0,7,4,5,6,9,10,11,8,15,12,16,17,23,20,21,22,17,18,19,16,29,30,31,28,27,24,25,26
]

@tournament_name = {name: 'World Cup 2018 - Russia',
                    description: 'The 2018 FIFA World Cup will be the 21st FIFA World Cup,
                    a quadrennial international football tournament contested by the men\'s
                    national teams of the member associations of FIFA. It is scheduled to
                    take place in Russia from 14 June to 15 July 2018,[2] after the country
                    was awarded the hosting rights on 2 December 2010.'
                  },
                  {  name:'World Cup 2022 - Qatar',
                    description: 'The 2022 FIFA World Cup is scheduled to be the 22nd edition of the FIFA World Cup,
                        the quadrennial international men\'s football championship contested by the national
                        teams of the member associations of FIFA. It is scheduled to take place in Qatar in 2022.
                        This will be the first World Cup held in Asia since the 2002 tournament in
                        South Korea and Japan. This will also be the first World Cup ever to be held in the Middle East,
                        and in an Arab and a Muslim-majority country.'

                  }

@tournament = ['world_cup_russia', 'world_cup_qatar']
@tournament_name.each_with_index do |tournament, index|
  image_path = "#{Rails.root}/app/assets/images/#{@tournament[index]}.png"
  image_file = File.new(image_path)
Tournament.create!(
    name: tournament[:name],
    description: tournament[:description],
    image: ActionDispatch::Http::UploadedFile.new(
      filename: File.basename(image_file),
      tempfile: image_file,
      type: MIME::Types.type_for(image_path).first.content_type
    )
)
end

@world_cup_national_teams.each do |team|
  image_path = "#{Rails.root}/app/assets/images/#{team.downcase.gsub(/\s+/, '')}.png"
  image_file = File.new(image_path)
  Team.create!(
    name: team,
    image: ActionDispatch::Http::UploadedFile.new(
      filename: File.basename(image_file),
      tempfile: image_file,
      type: MIME::Types.type_for(image_path).first.content_type
    )
  )
end


#World Cup Russia
#Round 1
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Russia').id,
  second_team_id: Team.find_by(name: 'Saudi Arabia').id,
  date: DateTime.new(2018,06,14,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Egypt').id,
  second_team_id: Team.find_by(name: 'Uruguay').id,
  date: DateTime.new(2018,06,15,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Morocco').id,
  second_team_id: Team.find_by(name: 'IR Iran').id,
  date: DateTime.new(2018,06,15,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Portugal').id,
  second_team_id: Team.find_by(name: 'Spain').id,
  date: DateTime.new(2018,06,15,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'France').id,
  second_team_id: Team.find_by(name: 'Australia').id,
  date: DateTime.new(2018,06,16,07,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Argentina').id,
  second_team_id: Team.find_by(name: 'Iceland').id,
  date: DateTime.new(2018,06,16,10,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Peru').id,
  second_team_id: Team.find_by(name: 'Denmark').id,
  date: DateTime.new(2018,06,16,13,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Croatia').id,
  second_team_id: Team.find_by(name: 'Nigeria').id,
  date: DateTime.new(2018,06,16,16,0,0)
)

Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Costa Rica').id,
  second_team_id: Team.find_by(name: 'Serbia').id,
  date: DateTime.new(2018,06,17,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Germany').id,
  second_team_id: Team.find_by(name: 'Mexico').id,
  date: DateTime.new(2018,06,17,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Brazil').id,
  second_team_id: Team.find_by(name: 'Switzerland').id,
  date: DateTime.new(2018,06,17,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Sweden').id,
  second_team_id: Team.find_by(name: 'Korea Republic').id,
  date: DateTime.new(2018,06,18,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Belgium').id,
  second_team_id: Team.find_by(name: 'Panama').id,
  date: DateTime.new(2018,06,18,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Tunisia').id,
  second_team_id: Team.find_by(name: 'England').id,
  date: DateTime.new(2018,06,18,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Colombia').id,
  second_team_id: Team.find_by(name: 'Japan').id,
  date: DateTime.new(2018,06,19,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Poland').id,
  second_team_id: Team.find_by(name: 'Senegal').id,
  date: DateTime.new(2018,06,19,12,0,0)
)
#round2
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Russia').id,
  second_team_id: Team.find_by(name: 'Egypt').id,
  date: DateTime.new(2018,06,19,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Portugal').id,
  second_team_id: Team.find_by(name: 'Morocco').id,
  date: DateTime.new(2018,06,20,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Uruguay').id,
  second_team_id: Team.find_by(name: 'Saudi Arabia').id,
  date: DateTime.new(2018,06,20,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'IR Iran').id,
  second_team_id: Team.find_by(name: 'Spain').id,
  date: DateTime.new(2018,06,20,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Denmark').id,
  second_team_id: Team.find_by(name: 'Australia').id,
  date: DateTime.new(2018,06,21,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'France').id,
  second_team_id: Team.find_by(name: 'Peru').id,
  date: DateTime.new(2018,06,21,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Argentina').id,
  second_team_id: Team.find_by(name: 'Croatia').id,
  date: DateTime.new(2018,06,21,15,0,0)
)

Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Brazil').id,
  second_team_id: Team.find_by(name: 'Costa Rica').id,
  date: DateTime.new(2018,06,22,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Nigeria').id,
  second_team_id: Team.find_by(name: 'Iceland').id,
  date: DateTime.new(2018,06,22,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Serbia').id,
  second_team_id: Team.find_by(name: 'Switzerland').id,
  date: DateTime.new(2018,06,22,15,0,0)
)


Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Belgium').id,
  second_team_id: Team.find_by(name: 'Tunisia').id,
  date: DateTime.new(2018,06,23,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Korea Republic').id,
  second_team_id: Team.find_by(name: 'Mexico').id,
  date: DateTime.new(2018,06,23,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Germany').id,
  second_team_id: Team.find_by(name: 'Sweden').id,
  date: DateTime.new(2018,06,23,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'England').id,
  second_team_id: Team.find_by(name: 'Panama').id,
  date: DateTime.new(2018,06,24,9,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Japan').id,
  second_team_id: Team.find_by(name: 'Senegal').id,
  date: DateTime.new(2018,06,24,12,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Poland').id,
  second_team_id: Team.find_by(name: 'Colombia').id,
  date: DateTime.new(2018,06,24,15,0,0)
)

#Round 3
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Saudi Arabia').id,
  second_team_id: Team.find_by(name: 'Egypt').id,
  date: DateTime.new(2018,06,25,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Uruguay').id,
  second_team_id: Team.find_by(name: 'Russia').id,
  date: DateTime.new(2018,06,25,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Spain').id,
  second_team_id: Team.find_by(name: 'Morocco').id,
  date: DateTime.new(2018,06,25,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'IR Iran').id,
  second_team_id: Team.find_by(name: 'Portugal').id,
  date: DateTime.new(2018,06,25,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Australia').id,
  second_team_id: Team.find_by(name: 'Peru').id,
  date: DateTime.new(2018,06,26,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Denmark').id,
  second_team_id: Team.find_by(name: 'France').id,
  date: DateTime.new(2018,06,26,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Nigeria').id,
  second_team_id: Team.find_by(name: 'Argentina').id,
  date: DateTime.new(2018,06,26,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Iceland').id,
  second_team_id: Team.find_by(name: 'Croatia').id,
  date: DateTime.new(2018,06,26,15,0,0)
)

Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Korea Republic').id,
  second_team_id: Team.find_by(name: 'Germany').id,
  date: DateTime.new(2018,06,27,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Mexico').id,
  second_team_id: Team.find_by(name: 'Sweden').id,
  date: DateTime.new(2018,06,27,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Serbia').id,
  second_team_id: Team.find_by(name: 'Brazil').id,
  date: DateTime.new(2018,06,27,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Switzerland').id,
  second_team_id: Team.find_by(name: 'Costa Rica').id,
  date: DateTime.new(2018,06,27,15,0,0)
)


Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Japan').id,
  second_team_id: Team.find_by(name: 'Poland').id,
  date: DateTime.new(2018,06,28,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Senegal').id,
  second_team_id: Team.find_by(name: 'Colombia').id,
  date: DateTime.new(2018,06,28,11,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'England').id,
  second_team_id: Team.find_by(name: 'Belgium').id,
  date: DateTime.new(2018,06,28,15,0,0)
)
Game.create!(
  tournament_id: Tournament.first.id,
  first_team_id: Team.find_by(name: 'Panama').id,
  second_team_id: Team.find_by(name: 'Tunisia').id,
  date: DateTime.new(2018,06,28,15,0,0)
)
