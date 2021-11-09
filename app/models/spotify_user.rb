class SpotifyUser < ApplicationRecord
  def access_token_expired?
    Time.now - updated_at > 3300
  end

  def verify_refresh_token
    if access_token_expired?
      body = {
        grant_type: 'refresh_token',
        refresh_token: refresh_token,
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }
      auth_response = RestClient.post 'https://accounts.spotify.com/api/token', body
      json_response = JSON.parse(auth_response)
      update access_token: json_response['access_token']
    end
  end
end
