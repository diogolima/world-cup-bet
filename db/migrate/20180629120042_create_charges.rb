class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.integer :amount
      t.references :user, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
