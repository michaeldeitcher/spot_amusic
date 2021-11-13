class ApplicationController < ActionController::Base
  before_action :load_spotify_session

  private

  def load_spotify_session
    @spotify_user = SpotifyUser.where( user_id: session[:spotify_user_id] ).first
  end

  def authenticate_user
    render json: {}, status: 401 unless @spotify_user
  end
end
