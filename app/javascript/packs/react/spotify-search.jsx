import React, { useState } from 'react';

const baseApiUri = process.env.API_ROOT

const SpotifySearch = props => {
    const [uuid, setUuid] = useState('')
    const [albumName, setAlbumName] = useState('')
    const [artistName, setArtistName] = useState('')

    const extractUUID = (e) => {
        let matches = /https:\/\/open.spotify.com\/album\/(\S*)\?/.exec(e.target.value)
        if( matches && matches[1]) {
            setUuid(matches[1])
            fetchSpotifyAlbum(matches[1])
        } else {
            setUuid('')
            setAlbumName('')
            setArtistName('')
        }
    }

    const fetchSpotifyAlbum = uuid => {
        let url = baseApiUri + 'spotify_searches?uuid=' + uuid;
        const params = {
            method: 'GET',
            headers: {
                'content-type': 'application/json; charset=UTF-8',
                'Accept': 'application/json'
            }
        }
        fetch(url,params).then(response=>response.json()).then(data => {
            setAlbumName(data['album_name'])
            setArtistName(data['artist_name'])
            props.onSpotifyResults(data['artist_name'], data['album_name'])
        })
    }

    const SpotifyResults = () => {
        if( uuid == '')
            return <div/>
        else {
            const appleSearch = `https://music.apple.com/us/search?term=${encodeURI(albumName + ' ' + artistName)}`
            return (
                <div>
                    <h4>UUID</h4>
                    <p>{uuid}</p>
                    <h4>Album Name</h4>
                    <p>{albumName}</p>
                    <h4>Artist Name</h4>
                    <p>{artistName}</p>
                </div>
            )
        }
    }

    return (
        <div>
            <label>Enter Spotify Link</label>
            <input type="url" id="url" name="url" onChange={extractUUID} style={{width: '100%'}}/>
            <SpotifyResults/>
        </div>
    )
}

export default SpotifySearch