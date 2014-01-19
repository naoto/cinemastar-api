class Broadcast < ActiveRecord::Base
  belongs_to :anime
  belongs_to :quarter

  def self.seasons
    Broadcast.find(:all).map { |b|
      { year: b.year.year,
        quarter: b.quarter.name
      }
    }.uniq
  end

end
