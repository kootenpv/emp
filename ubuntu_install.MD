# emp for clean Ubuntu install

Only to make VM look good:

    sudo apt-get install virtualbox-guest-dkms

"On-The-Way" requirements:

    sudo apt-get install python3-dev python3-tk libfreetype6-dev

Higher level Requirements:

    sudo apt-get install git emacs python3-pip

To be able to display UTF8 nicely, add to `.bashrc` (or your own language code):

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

Proper linking to local `python` bin

    export PATH=~/.local/bin:$PATH

Do a reboot:

    reboot

Installing `emp`

    git clone https://github.com/kootenpv/emp

Installing python packages useful for Emacs:

    cd emp
    pip3 install -r requirements.txt

*Important*: the following code wipes existing `.emacs settings` (no problem if it's a clean install)

Direct the initialization settings from .emacs to emp's init:

    echo '(setq user-emacs-directory "/home/ubuntu/emp/")' > ~/.emacs
    echo '(load (concat user-emacs-directory ".emacs.d/init.el"))' >> ~/.emacs

Start emacs:

    emacs
