class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :age
      t.integer :overall
      t.integer :potential
      t.integer :value
      t.integer :wage
      t.integer :total

      t.timestamps
    end
  end
end
