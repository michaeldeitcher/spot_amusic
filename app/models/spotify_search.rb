require 'rest-client'

class SpotifySearch < ApplicationRecord

  def search user
    user.verify_refresh_token
    header = {
      Authorization: "Bearer #{user.access_token}"
    }
    response = RestClient.get("https://api.spotify.com/v1/albums/#{uuid}", header)
    response_json = JSON.parse(response.body)
    album_name = response_json['name']
    artist_name = response_json['artists'][0]['name']
    self.results = {album_name: album_name, artist_name: artist_name}.to_json
  end
end
