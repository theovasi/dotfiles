if [ -e tokens.json ]
then
	python3 ~/.scripts/spotify_get_now_playing.py
else
	python3 ~/.scripts/spotify_get_tokens.py;python3 ~/.scripts/spotify_get_now_playing.py
fi
