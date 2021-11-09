class CreateSpotifySearches < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_searches do |t|
      t.string :uuid
      t.text :results

      t.timestamps
    end
  end
end
