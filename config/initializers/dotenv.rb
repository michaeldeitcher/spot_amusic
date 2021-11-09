if Rails.env.development?
  Dotenv.require_keys("SPOTIFY_CLIENT_ID", "SPOTIFY_REDIRECT_URI", "SPOTIFY_CLIENT_SECRET")
end