class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :anime_id
      t.integer :number
      t.string :title
      t.date :broadcast

      t.timestamps
    end
  end
end
