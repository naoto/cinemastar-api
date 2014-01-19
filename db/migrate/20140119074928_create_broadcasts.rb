class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.date :year
      t.integer :quarters_id
      t.integer :animes_id

      t.timestamps
    end
  end
end
