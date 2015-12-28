# -*- mode: snippet -*-
# name: append
# key: append
# --
with open("$1", "a") as f:
    f.write($2)