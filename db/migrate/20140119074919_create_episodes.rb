class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :animes_id
      t.integer :number
      t.string :title
      t.date :broadcast

      t.timestamps
    end
  end
end
