import os
import json
import requests
import base64


CLIENT_ID = '009ff74ab70c40d2a91453c79cfe03e4'
CLIENT_SECRET = 'e8612ec82c3547b09a79f1c4df362485'

def refresh_token():
    with open(os.path.expanduser('~')+'/.scripts/tokens.json', 'r') as token_file:
        tokens = json.load(token_file)

    url = 'https://accounts.spotify.com/api/token'

    payload = {
        'grant_type': 'refresh_token',
        'refresh_token': tokens['refresh_token'] 
    }

    client_info = CLIENT_ID+':'+CLIENT_SECRET
    headers = {
            'Authorization': 'Basic %s' % base64.b64encode(client_info.encode()).decode('ascii')
    }
    response = requests.request("POST", url, data=payload, headers=headers)
    response_dict = json.loads(response.content.decode('ascii'))

    tokens['access_token'] = response_dict['access_token']
    with open('tokens.json', 'w') as token_file:
        json.dump(tokens, token_file)

    return tokens['access_token']


def get_current_song():
    access_token = refresh_token()
    headers = {'Authorization': 'Bearer %s' % access_token}
    url = 'https://api.spotify.com/v1/me/player'
    response = requests.request('GET', url, headers=headers)
    response_dict = json.loads(response.content)
    artist = response_dict['item']['artists'][0]['name']
    song = response_dict['item']['name']
    print(artist + ' - ' + song)

if __name__ == '__main__':
    get_current_song()
