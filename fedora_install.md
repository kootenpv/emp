# emp for clean Fedora install

Reqs:

    sudo yum install python3-matplotlib

Emacs:

    sudo yum install emacs

Elpy requires `python` executable, so let's use `python3`

    sudo ln -s /usr/bin/python3 /usr/bin/python

Installing `emp`

    git clone https://github.com/kootenpv/emp

Installing python packages useful for Emacs:

    cd emp
    sudo pip3 install -r requirements.txt

*Important*: the following code wipes existing `.emacs settings` (no problem if it's a clean install)

Direct the initialization settings from .emacs to emp's init:

    echo '(setq user-emacs-directory "/home/fedora/emp/")' > ~/.emacs
    echo '(load (concat user-emacs-directory ".emacs.d/init.el"))' >> ~/.emacs

Start emacs, it will install packages:

    emacs

Close and start emacs again to have `python` work.
