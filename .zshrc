# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:/usr/bin:$PATH
#
# Julia
# export PATH=$HOME/juliav1.7:$HOME/.julia/bin:$HOME/.emacs.d/bin:$PATH

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# local installs
export PATH=$HOME/.local/bin:$PATH

# rust
export PATH=$HOME/.cargo/bin:$PATH

# go
# stable
# export PATH=/usr/local/go/bin:$PATH
# latest go dev version
# export PATH=$HOME/go/bin:$PATH
export PATH="/usr/local/sbin:$PATH"

# ruby
# export PATH=/usr/bin/gem:$PATH
# export PATH="$HOME/.rbenv/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Projects/dotfiles/.oh-my-zsh/custom"


# X11
# export PATH=/opt/X11/bin:$PATH
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="cloud"
# use below, if not using alacritty and installed xterm-256color-italic.terminfo
if ! { [ "$TERM" = "xterm-256color-italic" ] && [ -n "$TMUX" ]; } then
 export TERM="xterm-256color-italic"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"
setopt HIST_IGNORE_ALL_DUPS

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages fzf dash aliases zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='/usr/local/bin/nvim'


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias pc="pre-commit run"
alias ccc="cz c"
alias lc="colorls --sd -A"
alias pup="pip3 install -U pip"
alias pir="pip3 install -r requirements.txt"
alias editzsh="nvim ~/Projects/dotfiles/.zshrc"
alias pipdata="pip install -U pip; pip install pandas seaborn jupyterlab matplotlib numpy;"
alias nvimpip="$HOME/.config/nvim/.nvim-venv/bin/pip"

# Custom functions
function venv_is_active () {
  echo "Checking for active venv.."
  if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "..no active venv detected."
    return 0
  else
    echo "..detected active venv in: $VIRTUAL_ENV"
    return 1
  fi
}
function dvenv () {
  default_name=".${PWD##*/}_venv";
  venv_name="${@:-$default_name}";
  venv_is_active
  check_venv=$?
  if [[ $check_venv == 1 ]]; then
    echo "Deactivating ${VIRTUAL_ENV##*/}.."
    deactivate
    echo "..finished venv deactivate"
  fi
}
function avenv(){
  dvenv
  default_name=".${PWD##*/}_venv";
  venv_name="${@:-$default_name}";
  echo "Activating venv $venv_name..";
  source $venv_name/bin/activate;
  echo "..finished venv activate."
}

function cvenv(){
  echo "Venv creation started.."
  dvenv
  python_version="3.13.2";
  venv_name=".${PWD##*/}_venv"
  while getopts ":p:v:" option; do
    case "${option}" in
      p)
        python_version=${OPTARG}
        ;;
      v)
        venv_name=${OPTARG}
        ;;
      *)
        echo "usage: -p python version e.g. 3.10.2 | -v venv name e.g. .venv default='.<foldername>_venv'"
        ;;
    esac
  done
  echo "..setting local python version: $python_version..";
  pyenv local $python_version;
  echo "..creating venv with name: $venv_name..";
  if [[ -d "$venv_name" ]]; then
    echo "Error venv with name $venv_name already exists at $PWD"
    echo "Exiting venv creation."
  else
    python -m venv $venv_name;
    avenv $venv_name
    echo "..finished venv creation $venv_name with Python $python_version."
  fi
}


# ~/.zshrc
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi


if (( $+commands[pyenv] )); then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if (( $+commands[task] )); then
  eval "$(task --completion zsh)"
fi

if [[ -d "/opt/homebrew" ]]; then
  export PATH="/opt/homebrew/bin:opt/sqlite/bin:$PATH"
  export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
  # Compiler flags for C on macos
  # it's a mess. Don't do C on mac... 
  # export LDFLAGS="-L/usr/local/opt/llvm/lib"
  # export CPPFLAGS="-I/usr/local/opt/llvm/include"
  # set -ax LDFLAGS "-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
  export SDKROOT="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
  export CC="/usr/local/opt/llvm/bin/clang"
  export CXX="/usr/local/opt/llvm/bin/clang++"
  # To use the bundled libunwind please use the following LDFLAGS:
  # export LDFLAGS="-L/usr/local/opt/llvm/lib/unwind -lunwind"

  # To use the bundled libc++ please use the following LDFLAGS:
  # export LDFLAGS="-L/usr/local/opt/llvm/lib/c++ -L/usr/local/opt/llvm/lib/unwind -lunwind"
  # export ARCHFLAGS="-arch x86_64"
fi
if (( $+commands[rbenv] )); then
  eval "$(rbenv init - zsh)"
fi

