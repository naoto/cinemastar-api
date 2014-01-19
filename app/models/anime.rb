class Anime < ActiveRecord::Base
  has_many :episodes
  has_many :broadcasts
end
