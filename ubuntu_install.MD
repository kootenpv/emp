# emp for Ubuntu

Only to make VM look good:

    sudo apt-get install virtualbox-guest-dkms

"On-The-Way" requirements:

    sudo apt-get install python3-dev python3-tk libfreetype6-dev
    sudo apt-get install cairocffi    # for python 3.4 + ipython

Higher level Requirements:

    sudo apt-get install git emacs python3-pip

Installing `emp`

    git clone https://github.com/kootenpv/emp

Installing python packages useful for Emacs:

    cd emp
    pip3 install -r requirements.txt

Direct the initialization to the right path:

    # Manually use nano to edit .emacs:
    nano ~/.emacs

And add (removing `#` comment):

    # (setq user-emacs-directory "/home/ubuntu/emp/")
    # (load (concat user-emacs-directory ".emacs.d/init.el"))

    # On a fresh install you might do:
    # echo '(setq user-emacs-directory "/home/ubuntu/emp/")' > ~/.emacs
    # echo '(load (concat user-emacs-directory ".emacs.d/init.el"))' >> ~/.emacs

To be able to display UTF8 nicely, add to `.bashrc` (or your own language code):

    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8

Needed to link `pip3` to `pip` for `elpy` (hacky):

    sudo ln -s /usr/bin/pip3 /usr/bin/pip

Reboot to make VM look better, then start emacs:

    reboot
    emacs


echo '(setq user-emacs-directory "/home/ubuntu/emp/")' > ~/.emacs
echo '(load (concat user-emacs-directory ".emacs.d/init.el"))' >> ~/.emacs
