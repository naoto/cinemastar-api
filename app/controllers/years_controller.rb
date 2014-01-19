class YearsController < ApplicationController

  def index
    render :json => Broadcast.seasons
  end

  def show
    render :json => Anime.list(params[:id].to_i)
  end

end
