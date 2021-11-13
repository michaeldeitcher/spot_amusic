require 'jwt'
require 'rest-client'

class AppleSearch
  hours_to_live = 24
  private_key = ENV['APPLE_AUTH_KEY'] || File.read(Rails.root.join('config','AuthKey_9PQJFCKT6V.p8'))
  ecdsa_key = OpenSSL::PKey::EC.new private_key
  ecdsa_key.check_key

  time_now = Time.now.to_i
  time_expired = Time.now.to_i + hours_to_live * 3600
  algorithm = 'ES256'

  headers = {
    'typ': 'JWT',
    'kid': ENV['APPLE_MUSICKIT_KEY_ID']
  }

  payload = {
    'iss': ENV['APPLE_MUSICKIT_TEAM_ID'],
    'exp': time_expired,
    'iat': time_now
  }

  @@jwt = JWT.encode payload, ecdsa_key, algorithm, header_fields=headers
  @@api_root = 'https://api.music.apple.com/v1/'

  # for debugging with apple
  def self.musickit_curl url
    puts "curl -v -H \'Authorization: Bearer #{ @@jwt }\' \"#{url}\" "
  end

  def self.musickit_http_get url
    storefront = 'us'
    header = {
      Authorization: "Bearer #{@@jwt}"
    }
    response = RestClient.get url, header
    user_attr = JSON.parse(response.body)
  end

  def self.album_search artist, album
    as = AlbumSearch.new
    as.artist_name = artist
    as.album_name = album

    results = musickit_http_get @@api_root + as.query_path
    as.find_url_in_results results
  end

  class AlbumSearch
    attr_accessor :artist_name
    attr_accessor :album_name

    def query_path
      "/catalog/us/search?term=#{CGI.escape(album_name + ' ' + artist_name)}"
    end

    def find_url_in_results results
      albums = results.dig 'results', 'albums', 'data'
      album = albums&.find do |album|
        a = album.fetch 'attributes', {}
        a['name'] == album_name && a['artistName'] == artist_name
      end
      album&.dig('attributes', 'url')
    end
  end
end