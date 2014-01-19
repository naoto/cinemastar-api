class AnimesController < ApplicationController

  def index
    render :json => Anime.list
  end

  def show
    render :json => Anime.title(params[:id])
  end

end
