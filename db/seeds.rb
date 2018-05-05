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
  'Russia', 'Egypt', 'Saudi Arabia', 'Uruguay', #Group A
  'Portugal', 'Spain', 'Morocco', 'IR Iran', #Group B
  'France', 'Australia', 'Peru', 'Denmark', #Group C
  'Argentina', 'Iceland', 'Croatia', 'Nigeria', #Group D
  'Brazil', 'Switzerland', 'Costa Rica', 'Serbia', #Group E
  'Germany', 'Mexico', 'Sweden', 'Korea Republic', #Group F
  'Belgium', 'Panama', 'Tunisia', 'England', #Group G
  'Poland', 'Senegal', 'Colombia', 'Japan' #Group H
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
