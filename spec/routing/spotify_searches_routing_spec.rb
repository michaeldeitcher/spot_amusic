require "rails_helper"

RSpec.describe SpotifySearchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/spotify_searches").to route_to("spotify_searches#index")
    end

    it "routes to #create" do
      expect(post: "/spotify_searches").to route_to("spotify_searches#create")
    end
  end
end
