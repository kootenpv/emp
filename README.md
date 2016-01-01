## EMacs Python

<img src="https://github.com/kootenpv/emp/blob/master/resources/emacs.png" width="10%"></img>
<img src="https://github.com/kootenpv/emp/blob/master/resources/python.png" width="10%"></img></div>

**STATUS: PRE-ALPHA** -- did not check for bugs yet

Cross-platform settings for a nice EMacs Python environment. Easy to install, most powerful.

And naturally configurable as Emacs.

Introduction video **not yet here**.

Blog post **not yet here**

### Screenshot
<img src="https://github.com/kootenpv/emp/blob/master/resources/python-screenshot.png" width="49%"></img>
<img src="https://github.com/kootenpv/emp/blob/master/resources/python-screenshot.png" width="49%"></img>

### Table of contents

### Features

#### General features

- Easy to add packages (just add them in the list in "emp-external-packages.el")

- Nice standard theme, easy to take another theme, e.g.

  - [zenburn](http://wikemacs.org/wiki/File:Zenburn-theme.png)

  - [solarized-dark](http://wikemacs.org/wiki/File:Solarized-dark-theme.png)

  - [ubuntu](https://github.com/rocher/ubuntu-theme)

- Nice separation of functionality for init

- All Emacs benefits, among:

  - Great version control support by `magit` (emacs layer on top of git/svn etc)

  - Great local backups for file changes

  - Undo tree using `undo-tree-visualize` rather than linear undos

  - Modes for everything; `markdown-mode`, `dockerfile-mode` and so on

  - Recently opened files using `C-c r`

  - Find file with autocomplete using `C-x C-f`

#### Python features

- Python optimized for Interactive (REPL)

    - Timing after each execution

    - `C-0 C-<Return>` --> Set focus to an IPython instance and run code

    - `C-2 C-<Return>` --> Set focus to an IPython 2 instance and run code

    - `C-3 C-<Return>` --> Set focus to an IPython 3 instance and run code

    - `C-9 C-<Return>` --> Set focus to an IPyPy instance and run code

    - `C-<Return>` --> Run code in the focused instance

    - `C-<Return>` is smart; it runs either paragraphs, functions or classes (all with `C-<Return>`)

- `elpy` batteries included:

    - Optimized testing

    - Easy adding of imports using `C-c <Return>`

    - auto-completion from `jedi` (or `company`), result is dynamic completion

    - *No need to check for correctness of `PEP8`*; autopep8 / yapf for automatic formatting, on file-save

    - Imports ordered on save

- Best error reporting on the sideline, flymake & pylint + showing symbollic names for easy disabling

- `git-gutter` to see recent modifications in git repos

### Generic Installation

Next to the
1. Clone this where you want. I choose a folder for a specific version of a distro.

    `~/DISTRO/` such that `~/DISTRO/.emacs.d`

2. Put

        (setq user-emacs-directory "/home/ubuntu/emp-24.4/")
        (load (concat user-emacs-directory ".emacs.d/init.el"))

   in `~/.emacs`, given that `/home/ubuntu/` is your `$HOME` / `~`.

   If you want to be able to use several versions of Emacs, you can test for that.

3. Install Python 2 and/or 3 (preferably at least 3)

4. Run `pip install -r requirements.txt`

Your setup is complete.

Most likely there are issues. Have a look at [ubuntu_install.md](https://github.com/kootenpv/emp/blob/master/ubuntu_install.MD) to see if there are hints there. Please post an issue if it anything isn't working for you.

### Keyboard

At any moment, press <kbd>C-h m</kbd> to view all current keybindings.

Personal advice:

If using a laptop:

- bind <capslock> to control instead, much better

PC:

- Use both controls and alt's

Don't use C-f C-p etc, use arrows instead to prevent emacs pinky

#### Global

Keybinding                | Description
--------------------------|------------------------------------------------------------
<kbd>C-c r         </kbd> | View recently opened files
<kbd>M-return      </kbd> | Magit status; version control
<kbd>C-;           </kbd> | smart-comment: either on region or on line
<kbd>C-:           </kbd> | smart-uncomment
<kbd>C-'           </kbd> | expand-region: semantically enlarge selected region
<kbd>C-*           </kbd> | select all occurences of selected symbol/text
<kbd>C-x C-e       </kbd> | Eval a paragraph of emacs-lisp
<kbd>C-)           </kbd> | Move closing-character to the right by sexp
<kbd>C-(           </kbd> | Move closing-character to the left by sexp
<kbd>C-[backspace] </kbd> | backward-delete-word
<kbd>[backspace]   </kbd> | backspace-blank-lines-or-char
<kbd>[delete]      </kbd> | delete-blank-lines-or-char

#### Keychords

Key chords are awesome, just press two keys combinations quickly (in any order):

Keybinding                | Description
--------------------------|------------------------------------------------------------
<kbd>x q           </kbd> | Use it all the time: quit emacs no questions asked (dangerous!)
<kbd>s s           </kbd> | switch between buffers, can also work as "alt-tab"
<kbd>V V           </kbd> | Move quickly on screen using `avy-goto-char`
<kbd>h k           </kbd> | Reach your emacs config quickly
<kbd>P G      </kbd>      | Search in your python files from this folder down

#### Python Specific

Keybinding                | Description
--------------------------|------------------------------------------------------------
<kbd>C-return      </kbd> | Smart eval code
<kbd>[tab]         </kbd> | py-shift-right, indent to the right
<kbd>S-[tab]       </kbd> | py-shift-left (shift-tab), indent to the left
<kbd>C-[down]      </kbd> | elpy-nav-forward-block
<kbd>C-[left]      </kbd> | elpy-nav-backward-indent
<kbd>C-[right]     </kbd> | elpy-nav-forward-indent
<kbd>C-[up]        </kbd> | elpy-nav-backward-block
<kbd>M-[up]        </kbd> | move current line/region up
<kbd>M-[down]      </kbd> | move current line/region down
<kbd>C-M-f         </kbd> | forward-sexp
<kbd>C-M-b         </kbd> | backward-sexp
<kbd>M-.           </kbd> | elpy-goto-definition
<kbd>C-c C-d       </kbd> | elpy-doc
<kbd>C-c RET       </kbd> | elpy-importmagic-add-import
<kbd>C-c C-n       </kbd> | elpy-flymake-next-error
<kbd>C-c C-o       </kbd> | elpy-occur-definitions
<kbd>C-c C-p       </kbd> | elpy-flymake-previous-error
<kbd>C-c C-s       </kbd> | elpy-rgrep-symbol
<kbd>C-c C-t       </kbd> | elpy-test
<kbd>C-c C-v       </kbd> | elpy-check

### File structure

    . EMP
    │  
    ├──README.md
    ├── .emacs.d
    │   ├── init
    │   │   ├── emp-c++.el
    │   │   ├── emp-custom.el
    │   │   ├── emp-dired.el
    │   │   ├── emp-display.el
    │   │   ├── emp-external-packages.el
    │   │   ├── emp-external-plugins.el
    │   │   ├── emp-ido-hacks.el
    │   │   ├── emp-init.el
    │   │   ├── emp-keybindings.el
    │   │   ├── emp-misc-functions.el
    │   │   ├── emp-misc-settings.el
    │   │   ├── emp-r.el
    │   │   ├── emp-python.el
    │   │   └── navi.el
    │   ├── package-loader.el
    │   ├── packages
    │   │   ├── ag-20151219.903
    │   │   ├── archives
    │   │   ├── async-20151123.256
    │   │   ├── auto-complete-20150201.150
    │   │   ├── autopair-20140825.427
    │   │   ├── avy-20151222.245
    │   │   └── ...
    │   ├── themes
    │   │   └── kooten-theme.el
    │   ├── magnar-setup-ffip.el
    │   ├── next-at-point.el
    │   ├── dired-fixups.el
    │   ├── pyflymake.py
    │   ├── requirements.txt
    │   ├── smart-open.el
    │   ├── smart.el
    │   ├── tabbar-tweak.el
    │   ├── tempbuf.el
    │   ├── uniquify.el
    │   ├── web-mode.el
    │   └── xml-parse.el
    └── backups
