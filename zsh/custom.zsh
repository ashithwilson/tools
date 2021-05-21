# Load Oh my zsh!
source ~/Documents/personal/tools/zsh/.zshrc.oh-my-zsh
# p10k theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/Documents/personal/tools/zsh/.p10k.zsh ]] || source ~/Documents/personal/tools/zsh/.p10k.zsh

# Custom scripts
# Virtualbox VM helper script
vmscript="/Users/ashith/Documents/personal/tools/vm/virtualbox-cli.sh"
[[ -f "$vmscript" ]] && alias ub="bash $vmscript"
# iterm2 color for SSH
source "/Users/ashith/Documents/personal/tools/colorssh/colorssh.sh"
#Enable z.sh
[ -f ~/Documents/personal/tools/zsh/z.sh ] && source ~/Documents/personal/tools/zsh/z.sh
#Enable Fuzzy Search
[ -f ~/Documents/personal/tools/zsh/.fzf.zsh ] && source ~/Documents/personal/tools/zsh/.fzf.zsh

export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set $PATH
export PATH="/usr/local/sbin:/usr/local/opt/python@3.8/bin:$HOME/bin:/usr/local/bin:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

#functions
function gpr() {
  # Opens git PR for current branch
  git rev-parse || return 1
  github_url=$(git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/')
  branch_name=$(git symbolic-ref HEAD | cut -d"/" -f 3,4)
  pr_url="${github_url}/compare/${branch_name}"
  open "$pr_url"
}

function gw(){
  # Opens Github webui from PWD or filename
  git rev-parse || return $?
  git_remote_url=$(git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/')
  base_repo=$(git rev-parse --show-toplevel)
  fname=${1:-"$PWD"}
  fname=$(realpath "$fname")
  type=tree
  [[ -f "$fname" ]] && type=blob
  # parameter expr url_path = PWD - base_repo
  url_path=${fname#"$base_repo"}
  branch_name=$(git branch --show-current)
  url=${git_remote_url}/${type}/${branch_name}${url_path}
  echo "$url" && open "$url"
}

function ctmp() {
  # Create and open a new tmp file for new day
  local base_dir="/Users/ashith/Documents/daily-scratch-pad"

  local dir="$base_dir"$(date "+/%Y/%m/")
  [[ -d "$dir" ]] || mkdir -p "$dir"
  local fname=${dir}$(date "+%d").md
  if [[ -f "$fname" ]]; then
    code "$fname"
  else
    touch "$fname" && code "$fname"
  fi
}

# Alias
alias ll='exa -al'
alias lll='ll'
alias l='ll'
alias cdw='cd /Users/ashith/Documents/cloudera'
alias cdp='cd /Users/ashith/Documents/personal'
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
alias c='code'
