# Stolen from the company snack drawers
# The various escape codes that we can use to color our prompt.
# TODO: consider pivoting to tput commands instead of escape sequences
# shellcheck disable=SC1117,2034
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[1;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[1;34m\]"
       CYAN="\[\033[1;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_MAGENTA="\[\033[1;35m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"


# Detect whether the current directory is a git repository.
function is_git_repository {
  git branch > /dev/null 2>&1
}

# Determine the branch/state information for this git repository.
function new_set_git_status {
  # shellcheck disable=SC2155
  local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  if [[ $branch = "HEAD" ]]; then
      branch="detached*$(git rev-parse --short HEAD 2>/dev/null)"
  fi

  local untracked
  git ls-files --other --directory --exclude-standard 2>/dev/null | sed -n q1 || untracked="${LIGHT_RED}‡"

  local dirty

  local staged
  if [[ $branch != "detached*" && $(git config --bool bash.showDirtyState) != "false" ]]; then
    git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty="${LIGHT_RED}✗"
    git diff --no-ext-diff --quiet --cached --exit-code --ignore-submodules 2>/dev/null || staged="${LIGHT_RED}✓"
  fi

  local stash
  git rev-parse --verify --quiet refs/stash >/dev/null && stash="${YELLOW}↗"

  local upstream
  case "$(git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)" in
    "") # no upstream
        upstream="" ;;
    "0  0") # equal to upstream
        upstream="${CYAN}=" ;;
    "0  "*) # behind upstream
        upstream="${YELLOW}↓" ;;
    *"  0") # ahead of upstream
        upstream="${YELLOW}↑" ;;
    *)      # diverged from upstream
        upstream="${YELLOW}↕" ;;
  esac

  local spacer
  if [[ -n $dirty || -n $staged || -n $stash || -n $upstream ]]; then
    spacer=' '
  fi
  GITSTATUS="${CYAN}${branch}${spacer}${COLOR_NONE}${untracked}${dirty}${staged}${upstream}${stash}${COLOR_NONE} "
}

# Determine the branch/state information for this git repository.
function old_set_git_status {
  # Capture the output of the "git status" command.

  git_status="$(git status 2> /dev/null)"

  # Set color based on clean/staged/dirty.
  if [[ ${git_status} =~ "working tree clean" ]]; then
    state="${GREEN}"
  elif [[ ${git_status} =~ "Changes to be committed" ]]; then
    state="${YELLOW}"
  else
    state="${LIGHT_RED}"
  fi

  # Set arrow icon based on status against remote.
  remote_pattern="# Your branch is (ahead|behind)+ "
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi

  # Get the name of the branch.
  branch_pattern="^(# )?On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[2]}
  fi

  # Set the final branch string.
  GITSTATUS="${state}(${branch})${remote}${COLOR_NONE} "
}

# Return the prompt symbol to use, colorized based on the return value of the
# previous command.
function set_prompt_symbol () {
  # shellcheck disable=SC2086
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${LIGHT_RED}\$${COLOR_NONE}"
  fi
}

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=''
  else
      # shellcheck disable=SC2006
      PYTHON_VIRTUALENV="${CYAN}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

function set_docker_machine () {
  # Add docker-machine to terminal prompt
  # check if `docker-machine` command exists
  if command -v docker-machine > /dev/null; then
    # fetch the first running machine name
    # shellcheck disable=SC2155
    local machine=$(docker-machine ls | grep "Running" | head -n 1 | awk '{ print $1 }')
    if [ "$machine" == "" ]; then
      DOCKER_MACHINE=''
    else
      DOCKER_MACHINE="$YELLOW\$(__docker_machine_ps1)${COLOR_NONE} "
    fi
  fi
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  set_prompt_symbol $?

  # Use the PYTHON_VIRTUALENV variable.
  set_virtualenv
  # Check for docker
  set_docker_machine

  # Set the GITSTATUS variable.
  if is_git_repository ; then
    new_set_git_status
  else
    GITSTATUS=''
  fi

  # number of dirs to keep in path part of prompt
  PROMPT_DIRTRIM=4


  # Set the bash prompt variable.
  PS1="╭─ ${DOCKER_MACHINE}${PYTHON_VIRTUALENV}${GREEN}\u@\h ${GITSTATUS}${LIGHT_GRAY}\w${COLOR_NONE}\n╰── ${PROMPT_SYMBOL} "
}

# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=set_bash_prompt
