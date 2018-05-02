class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.text :description
      t.attachment :image

      t.timestamps
    end
  end
end
