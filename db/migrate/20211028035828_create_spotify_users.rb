class CreateSpotifyUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_users do |t|
      t.string :user_id, index: true
      t.string :display_name
      t.string :access_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
