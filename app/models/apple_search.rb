require 'jwt'
require 'rest-client'

class AppleSearch
  hours_to_live = 24
  private_key = File.read(Rails.root.join('config','AuthKey_9PQJFCKT6V.p8'))
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

  def jwt
    @@jwt
  end

  def musickit_curl url
    puts "curl -v -H \'Authorization: Bearer #{ jwt }\' \"#{url}\" "
  end

  def musickit_http_get url
    storefront = 'us'
    header = {
      Authorization: "Bearer #{jwt}"
    }
    response = RestClient.get url, header
    user_attr = JSON.parse(response.body)
  rescue RestClient::InternalServerError => e
    puts 'internal server exception raised'
    puts e
  end

  #url = 'https://api.music.apple.com/v1/storefronts/us'
  #url = 'https://api.music.apple.com/v1/catalog/us/albums/310730204'
end

