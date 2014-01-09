# Ignore deprecations on GAE
# alias manage.py='python2.5 -Wignore manage.py'

# Ensure XCode 4 GCC doesn't try and compile PPC version of Apps
# alias easy_install='sudo env ARCHFLAGS="-arch i386 -arch x86_64" easy_install-2.5'

# Append historyrather than overwrite. Stops concurrent shells from blatting each other's history
shopt -s histappend

# Add typical Unix pathnames
export PATH=~/bin:/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/sbin:/Users/mike.maccana/Utilities/deploy:~/Applications/AndroidDevTools/sdk/platform-tools

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Node seems to have trouble finding globally installed modules without setting NODE_PATH
export NODE_PATH=/usr/local/lib/node_modules

# http://slackrw.wordpress.com/2010/07/31/mac-os-x-10-6-snow-leopard-re-enable-lcd-font-smoothing-for-some-monitors-via-macosxhints-com/
#defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# History for node.
# Requires 'npm install -g repl.history'
function node-repl () {
    repl.history
}

export PS1='\w: '
#export PS1="\[\033[G\]\w \$ "



# For Charles Proxy. ALL_PROXY is for Curl because curl sucks.
#export HTTP_PROXY=http://localhost:2222/; export ALL_PROXY=http://localhost:2222/

alias lsof='lsof -nP -i'

function android-emulator () {
    # ~/Applications/AndroidDevTools/sdk/tools/emulator -avd Nexus7Android44
    ~/Applications/AndroidDevTools/sdk/tools/emulator -avd Android43Fast
}

function android-console-log () {
    adb logcat browser:V *:S
}

function mate () {
    echo 'Type subl instead.'
}

function fucking () {
    sudo "$@"
}

function gg () {
    git grep -n -i "$@"
}

function findname () {
    find . -iname "$@"
}

function filemerge () {
    /Applications/Xcode.app/Contents//Applications/FileMerge.app/Contents/MacOS/FileMerge -left $1 -right $2
}



# Charles Reinstall
# keytool -list -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit | grep charles
# sudo keytool -import -alias charles -file /Applications/Charles.app//Contents/doc/charles-proxy-ssl-proxying-certificate.crt -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit

# Save the field separator
export REGULAR_IFS=$IFS
export NEWLINE_IFS=$'\n'

# Always append history, not overwrite it.
shopt -s histappend
export PROMPT_COMMAND="history -a"
export HISTCONTROL="ignorespace:ignoredups"
export HISTFILESIZE="100000"

# Set timezone
export TZ="Europe/London"

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
