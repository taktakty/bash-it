# Nature Bash Prompt
#
# Configuration:
#   * To visualize python environment (virtualenv and conda) add in your .bash_profile the following line:
#       export NATURE_THEME_SHOW_PYTHON=true

# Default setting
NATURE_THEME_SHOW_PYTHON="${NATURE_THEME_SHOW_PYTHON:=false}"

if tput setaf 1 &> /dev/null; then
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 254)
	  BLUE=$(tput setaf 87)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
	  BLUE=$(tput setaf 14)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_dirty () {
  if [ "$(git status 2> /dev/null | tail -n1 | cut -c 1-17)" == "nothing to commit" ] ; then
    echo " ✅ "
  else
    echo "❗️"
  fi
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
env_prompt () {
  # echo -e "$(virtualenv_prompt)"
  if [ "$(virtualenv_prompt)" != "" ] ; then
    echo -e "🐠 ($(virtualenv_prompt | tr -d ' |')) "
  fi
}

function prompt_command() {
  PS1="$(echo 🌵) \[$GREEN\](\w)\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo -e \" 🐳 \")\[$BLUE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"

  if [ "$NATURE_THEME_SHOW_PYTHON" = true ] ; then
    PS1="\[${BOLD}${WHITE}\]$(env_prompt)"$PS1
  fi
}

safe_append_prompt_command prompt_command
