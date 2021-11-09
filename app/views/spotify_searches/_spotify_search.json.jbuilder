results = JSON.parse(spotify_search.results)

json.uuid spotify_search.uuid
json.album_name results['album_name']
json.artist_name results['artist_name']
