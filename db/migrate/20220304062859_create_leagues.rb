class CreateLeagues < ActiveRecord::Migration[6.1]
  def change
    create_table :leagues do |t|
      t.string :name

      t.timestamps
    end
    add_reference :teams, :league, null: false, foreign_key: true
  end
end
