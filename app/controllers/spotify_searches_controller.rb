class SpotifySearchesController < ApplicationController
  # GET /spotify_searches or /spotify_searches.json
  def index
    spotify_search = SpotifySearch.new()
    spotify_search.uuid = params[:uuid]
    spotify_search.search(@spotify_user)
    render json: spotify_search.results
  end
end
