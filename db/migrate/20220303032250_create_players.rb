class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :sofifa_id
      t.string :player_url
      t.string :dob
      t.string :nationality_name
      t.string :preferred_foot
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
