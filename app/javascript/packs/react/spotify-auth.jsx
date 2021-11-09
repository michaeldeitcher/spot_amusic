import React, { useState } from 'react'

const baseApiUri = process.env.API_ROOT
const LogoutButton = () => (
    <a className='button' data-method="delete" href={`${baseApiUri}sessions`} rel="nofollow">Log out</a>
)
const LoginButton = () => (
    <a className='button' href={`${baseApiUri}spotify_tokens/new`}>Login</a>
)

const spotifyUserData = document.getElementById('spotify-user');

const SpotifyAuth = () => {
    if( spotifyUserData ){
        return (
            <div>
                <div>Hello {spotifyUserData.value}</div>
                <LogoutButton/>
            </div>
        )
    } else {
        return (<div><LoginButton/></div>)
    }
}

export default SpotifyAuth