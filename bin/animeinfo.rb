#!/usr/bin/env ruby

require 'yaml'
require 'date'

def get_quarter
  season = case Date.today.month
           when 0..3
             "冬"
           when 3..6
             "春"
           when 6..9
             "夏"
           when 9..12
             "秋"
           end
  Quarter.find_by_name(season).id
end

def get_year(date)
  ymd = date.split("-")
  Date::new(ymd[0].to_i, ymd[1].to_i, ymd[2].to_i)
end

anime_data = YAML.load_file("config/anime_api.yml")

anime_data.each do |url|
  data = JSON.open(url)
  items = data["response"]["item"].kind_of?(Array) ? data["response"]["item"] : [data["response"]["item"]]
  items.each do |item|
    anime = Anime.find_by_name(item["title"])
    if anime.nil?
      new_anime = Anime.new
      new_anime.name = item["title"]
      new_anime.last_episode = item["episode"]
      new_anime.save
      if item["state"] == "onair"
        broadcast = Broadcast.new
        broadcast.year = get_year("#{Date.today.year}-1-1")
        broadcast.anime_id = new_anime.id
        broadcast.quarter_id = get_quarter
        broadcast.save
        1.upto(item["next"].gsub(/^(\d+)+.+$/,'\1').to_i) do |num|
          episode = Episode.new
          episode.anime_id = new_anime.id
          episode.number = num
          episode.save
        end
      elsif item["state"] == "new"
        broadcast = Broadcast.new
        broadcast.year = get_year(item["next"])
        broadcast.anime_id = new_anime.id
        broadcast.quarter_id = get_quarter
        broadcast.save
      end
    else
      if anime.broadcasts.empty?
        if item["state"] == "onair"
          broadcast = Broadcast.new
          broadcast.year = get_year("#{Date.today.year}-1-1")
          broadcast.anime_id = new_anime.id
          broadcast.quarter_id = get_quarter
          broadcast.save
          1.upto(item["next"].gsub(/^(\d+).+$/,'\1').to_i) do |num|
            episode = Episode.new
            episode.anime_id = new_anime.id
            episode.number = num
            episode.save
          end
        elsif item["state"] == "new"
          broadcast = Broadcast.new
          broadcast.year = get_year(item["next"])
          broadcast.anime_id = new_anime.id
          broadcast.quarter_id = get_quarter
          broadcast.save
        end
      else
        ep = item["next"].gsub(/^(\d).+$/,'\1').to_i
        if !anime.episodes.empty? and ep > anime.episodes.last.number
          anime.episodes.last.number.next.upto(ep) do |num|
            episode = Episode.new
            episode.anime_id = anime.id
            episode.number = num
            episode.save
          end
        end
      end
    end
  end
end
