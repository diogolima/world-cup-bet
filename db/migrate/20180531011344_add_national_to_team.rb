class AddNationalToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :team_type, :string
  end
end
