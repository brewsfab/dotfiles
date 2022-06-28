#export AWS_PROFILE=$(echo `head -n1 ~/.aws/credentials| tr -d '[]'`)
#export AWS_PROFILE=$(echo `head -n1 ~/.aws/credentials| tr -d '[]'`)
#export AWS_PROFILE=$(grep -r "\[*\]" ~/.aws/credentials -h| tr -d '[]')
export ENVPATH=/home/will/Documents/env_smd/demand_prediction/input-crawl-historical/restore_everyday_errors/env
export EDITOR=vim
export AWS_CLI_AUTO_PROMPT=on-partial

alias aws='aws --profile $AWS_PROFILE'
alias cdk='cdk --profile $AWS_PROFILE'
alias jn='jupyter notebook'
alias asl='awsprofileselection && aws sso login'

alias awscred='pbpaste > ~/.aws/credentials'
alias dockawslogin='aws ecr get-login-password --region ap-northeast-1 --profile $AWS_PROFILE | docker login -u AWS --password-stdin  $(echo $ECR_REPO) '
alias python='python3'
alias python3='python3.8'
alias venv='python3 -m venv'

alias sb='. ~/.bash_profile'
alias vb='vi ~/.bash_profile'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# GIT RELATED
alias gs="git status"

#VIM
#export NVIMRC=/home/will/.config/nvim/init.vim
alias vi="nvim"
alias vim="nvim"
alias vimdiff="vim -d"

#aws credential updater (from the clipboard)
awscredupdater(){
	credFile=~/.aws/credentials
	#read the clipboard (pbpaste for Mac)
	#ensure that there is [xxxxxx] in it
	#copiedpf=$(pbpaste)

    #pf=$( echo $copiedpf | head -1 )
    pf=$( pbpaste | head -1 )
    # | head -1)
    #  | tr -d '[]')
    #echo $pf
    #echo

	#Need to select the similar line in ~/.aws/credentials
	#ln=$(awk -v line=$pf '$0 == line {print "this is the line number", NR, "from", FILENAME}' $credFile)
	ln=`awk -v line=$pf '$0 == line {print "this is the line number", NR, "from", FILENAME}' $credFile`

    echo $ln

}

# need choose (choose-gui in MacOS) to be installed
awsprofileselection(){
	pfl=$(grep -r "\[*\]" ~/.aws/credentials -h| tr -d '[]' | dmenu -l 10)
	export AWS_PROFILE=$pfl
}

mkcd(){
	mkdir -p "$1" && cd "$1";
}

makeenv(){

	python3 -m venv "${1:-env}" && actenv "${1:-env}";
}

actenv(){

	. "${1:-env}"/bin/activate
}

grepir(){

	if [[ -z $1 ]];then
		echo -e "Usage: $0 pattern [folder]"
		return 1
	fi

	grep -ir "$1" "${2:-.}"
}

eval `dircolors ~/.dir_colors`

export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=~/.npm-global/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
alias config='/usr/bin/git --git-dir=/home/will/.dotfiles/ --work-tree=/home/will'
