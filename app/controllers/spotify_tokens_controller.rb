require 'rest-client'

class SpotifyTokensController < ApplicationController
  def new
    query_params = {
      client_id: ENV['SPOTIFY_CLIENT_ID'],
      response_type: "code",
      redirect_uri: ENV['SPOTIFY_REDIRECT_URI'],
      scope: "",
      show_dialog: true
    }
    redirect_to "https://accounts.spotify.com/authorize?#{query_params.to_query}"
  end

  def callback
    if params[:error]
      flash[:alert] = "Login with Spotify failure"
      redirect_to "/"
    else
      body = {
        grant_type: "authorization_code",
        code: params[:code],
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        redirect_uri: ENV['SPOTIFY_REDIRECT_URI'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_json = JSON.parse(auth_response.body)

      header = {
        Authorization: "Bearer #{auth_json['access_token']}"
      }
      user_response = RestClient.get('https://api.spotify.com/v1/me', header)
      user_json = JSON.parse(user_response)

      u = SpotifyUser.find_or_create_by(user_id: user_json['id'])
      u.update(access_token: auth_json['access_token'], refresh_token: auth_json['refresh_token'], display_name: user_json['display_name'])
      session[:spotify_user_id] = u.user_id
      flash[:notice] = 'Successful login with spotify'
      redirect_to "/"
    end
  end
end