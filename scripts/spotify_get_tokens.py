import os, sys
import urllib.parse
import webbrowser
import base64
import threading
import logging

import requests
import json
from flask import Flask, redirect, request, url_for, make_response, render_template

app = Flask(__name__)
log = logging.getLogger('werkzeug')
log.disabled = True

CLIENT_ID = '009ff74ab70c40d2a91453c79cfe03e4'
CLIENT_SECRET = 'e8612ec82c3547b09a79f1c4df362485'


@app.route('/')
def process_auth_response():
    authorization_code = request.args.get('code')
    
    url = "https://accounts.spotify.com/api/token"

    payload = {
        'grant_type': 'authorization_code',
        'code': authorization_code,
        'redirect_uri': 'http://127.0.0.1:5000/'
    }
    client_info = CLIENT_ID+':'+CLIENT_SECRET
    headers = {'Authorization': 'Basic %s' % base64.b64encode(client_info.encode()).decode('ascii')}

    response = requests.request("POST", url, data=payload, headers=headers)
    response_dict = json.loads(response.content.decode('ascii'))

    tokens = {
        'access_token': response_dict['access_token'],
        'refresh_token': response_dict['refresh_token']
    }
    with open(os.path.expanduser('~')+'/.scripts/tokens.json', 'w+') as token_file:
        json.dump(tokens, token_file)

    return redirect('success')

@app.route('/success')
def auth_success():
    request.environ.get('werkzeug.server.shutdown')()
    return 'Got tokens, you may close this tab'

@app.route('/login')
def authorize():
    response_type = 'code'
    scope = 'user-read-private user-read-playback-state'
    redirect_uri = 'http://127.0.0.1:5000/'
    response_type = 'code'
    return redirect(('https://accounts.spotify.com/authorize?client_id=%s&' % CLIENT_ID +
                     'scope=%s&redirect_uri=%s' % (urllib.parse.quote(scope), urllib.parse.quote(redirect_uri))+
                     '&response_type=%s' % response_type))

def open_browser():
    webbrowser.open('http://127.0.0.1:5000/login')

if __name__ == '__main__':
    sys.stdout = open(os.devnull, 'w')
    app_thread = threading.Thread(target=app.run)
    browser_thread = threading.Thread(target=open_browser)
    app_thread.start()
    browser_thread.start()
    while app_thread.is_alive() or browser_thread.is_alive():
        pass
