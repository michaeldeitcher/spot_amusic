class SpotifySearchesController < ApplicationController
  before_action :set_spotify_search, only: %i[ show edit update destroy ]

  # GET /spotify_searches or /spotify_searches.json
  def index
    @spotify_searches = SpotifySearch.all
  end

  # POST /spotify_searches or /spotify_searches.json
  def create
    @spotify_search = SpotifySearch.new(spotify_search_params)
    spotify_user = SpotifyUser.find_by_user_id session[:spotify_user_id]

    respond_to do |format|
      if @spotify_search.search spotify_user
        format.html { redirect_to @spotify_search, notice: "Spotify search was successfully created." }
        format.json { render :show, status: :created, location: @spotify_search }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spotify_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spotify_searches/1 or /spotify_searches/1.json
  def destroy
    @spotify_search.destroy
    respond_to do |format|
      format.html { redirect_to spotify_searches_url, notice: "Spotify search was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spotify_search
      @spotify_search = SpotifySearch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spotify_search_params
      params.require(:spotify_search).permit(:uuid, :results)
    end
end
