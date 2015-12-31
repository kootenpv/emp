Ensure that

- ipython
- python
- pip

Are working on the command line, and that they are pointing to the same version, e.g. Python 2.7 or 3.5.

Run python/ipython to read the version, and `pip --version` to find `pip`'s version.

Next:

    git clone https://github.com/kootenpv/emp
    cd emp

Then, generally run `sudo pip install -r requirements.txt`

Direct the initialization settings from .emacs to emp's init:

    # Make backup of previous .emacs if it existed
    mv ~/.emacs ~/.emacs_before_emp
    echo '(setq user-emacs-directory "/home/fedora/emp/")' > ~/.emacs
    echo '(load (concat user-emacs-directory ".emacs.d/init.el"))' >> ~/.emacs
