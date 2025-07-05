from libqtile.lazy import lazy


@lazy.function
def fake_fullscreen(qtile):
    atom = set([qtile.conn.atoms["_NET_WM_STATE_FULLSCREEN"]])
    win = qtile.current_window.window
    state = set(win.get_property('_NET_WM_STATE', 'ATOM', unpack=int))
    if atom & state:
        state -= atom
    else:
        state |= atom
    win.set_property('_NET_WM_STATE', list(state))
