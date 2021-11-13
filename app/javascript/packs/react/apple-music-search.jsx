import React, { useState, useEffect } from 'react';

const baseApiUri = process.env.API_ROOT

const AppleMusicSearch = (props) => {
    useEffect(() =>{
        fetchAppleMusicUrl(props.artistName, props.albumName)
        }, [props.artistName, props.albumName]
    )
    const [appleMusicUrl, setAppleMusicUrl] = useState('')

    const fetchAppleMusicUrl = (artistName, albumName) => {
        if(artistName === '' || albumName === '')
            return;
        let url = baseApiUri + `apple_music_searches?album=${encodeURIComponent(albumName)}&artist=${encodeURIComponent(artistName)}`
        const data = {
            authenticity_token: document.getElementsByName("authenticity_token")[0].value
        }
        const params = {
            method: 'GET',
            headers: {
                'content-type': 'application/json; charset=UTF-8',
                'Accept': 'application/json'
            },
        }
        fetch(url,params).then(response=>response.json()).then(data => {
            setAppleMusicUrl(data[0])
        })
    }

    if( appleMusicUrl === '' ) {
        return (
            <div></div>
        )
    } else {
        return (
            <div>
                <a href={appleMusicUrl} target={'_blank'}>{props.artistName}, {props.albumName} on Apple Music</a>
                <br/>
                <a href={appleMusicUrl.replace('https:', 'musics:')} target={'_blank'}>Launch Apple Music App</a>
            </div>
        )
    }
}

export default AppleMusicSearch