class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.date :year
      t.integer :quarter_id
      t.integer :anime_id

      t.timestamps
    end
  end
end
