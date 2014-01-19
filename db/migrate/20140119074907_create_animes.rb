class CreateAnimes < ActiveRecord::Migration
  def change
    create_table :animes do |t|
      t.string :name
      t.integer :last_episode
      t.integer :serieses_id

      t.timestamps
    end
  end
end
