class Anime < ActiveRecord::Base
  has_many :episodes
  has_many :broadcasts

  def self.list(year = nil, quater = nil)
    if year.nil?
      Anime.all.map { |h|
        { id: h.id,
          title: h.name,
          next_episode: h.episodes.last ? h.episodes.last.number : nil,
          last_episode: h.last_episode,
          year: h.broadcasts.first.year.year,
          season: h.broadcasts.first.quarter.name
        }
      }
    elsif quater.nil?
      Broadcast.where(year: Date::new(year,1,1)).map { |h|
        { id: h.anime.id,
          title: h.anime.name,
          next_episode: h.anime.episodes.last ? h.anime.episodes.last.number : nil,
          last_episode: h.anime.last_episode,
          year: h.year.year,
          season: h.quarter.name
        }
      }
    else
      Broadcast.where(year: Date::new(year,1,1)).and(quater_id: quater).map { |h|
        { id: h.anime.id,
          title: h.anime.name,
          next_epidose: h.anime.episodes.last ? h.anime.episodes.last.number : nil,
          last_episode: h.anime.last_episode,
          year: h.year.year,
          season: h.quater.name
        }
      }
    end
  end

  def self.title(title)
    Anime.where(name: title).map{ |h|
      { id: h.id,
        title: h.name,
        next_episode: h.episodes.last ? h.episodes.last.number : nil,
        last_episode: h.last_episode,
        year: h.broadcasts.first.year.year,
        season: h.broadcasts.first.quarter.name,
        episodes: h.episodes.map { |e|
          {
            number: e.number
          }
        }
      }
    }
  end
end
