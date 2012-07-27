export PS1='\w: '
export PATH=$PATH:/usr/local/sbin:/Users/mike.maccana/Utilities/deploy

# For Charles Proxy
#export HTTP_PROXY=http://localhost:2222/




# Sometimes we accidentally paste in the hostname with http attached. Strip it.
function strip_scheme () {
    if [[ "$1" == *http://* ]]
    then
        DESTINATION_HOST="$(echo $1 | sed 's#://# #' | awk '{print $2}')"
    else
        DESTINATION_HOST=$1
    fi  
}


# SSH with amazon preset options
function amazonssh () {
    strip_scheme $1
    if [ -z $DESTINATION_HOST ]
    then
        echo "Please specify a host"
    else
        ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i ~/.ssh/id_socialapps ec2-user@$DESTINATION_HOST
    fi
}

# SSH with amazon preset options
function amazonscp () {
    SOURCE=$1
    strip_scheme $2
    scp -rv -o StrictHostKeyChecking=no -o ConnectTimeout=5 -i ~/.ssh/id_socialapps $SOURCE $DESTINATION_HOST
}

# Playbook BAT files
function install_bar () {
    PLAYBOOKIP=$1
    PBPASSWORD=$2
    BARFILE=$3
    java -Xmx512M -jar BarDeploy.jar -installApp -device $PLAYBOOKIP -password $PBPASSWORD $BARFILE
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
export HISTFILESIZE="8000"

# Amazon EC2 tools
export AWS_CREDENTIAL_FILE="/Users/mike.maccana/.aws_credentials"
export AWS_AUTO_SCALING_HOME="/Applications/AutoScaling-1.0.49.1"
export AWS_ELB_HOME="/Applications/ElasticLoadBalancing-1.0.17.0"
export AWS_CLOUDWATCH_HOME="/Applications/CloudWatch-1.0.12.1"
export PATH=$PATH:"${AWS_AUTO_SCALING_HOME}/bin":"${AWS_ELB_HOME}/bin":"${AWS_CLOUDWATCH_HOME}/bin"
export AWS_CLOUDWATCH_URL=https://monitoring.us-east-1.amazonaws.com  

# Java
export MAVEN_OPTS="-Xmx1024M"

# Set timezone
export TZ="Europe/London"

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# BV Development Environment Variables
# export JAVA_HOME="/Library/Java/Home"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
export XMLBEANS_HOME="/tools/xmlbeans-2.5.0"
export CLASSPATH="$XMLBEANS_HOME/lib/xbean.jar:$XMLBEANS_HOME/lib/jsr173_1.0_api.jar:$CLASSPATH"
export PATH="/svnwork/svnscripts/trunk/working/bin:/svnwork/techservices/trunk/working/tools/bin:/opt/idea/bin:$XMLBEANS_HOME/bin:$PATH"

# From http://www.robertsosinski.com/2008/01/26/starting-amazon-ec2-with-mac-os-x/
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=$(ls $EC2_HOME/pk-*.pem)
export EC2_CERT=$(ls $EC2_HOME/cert-*.pem)

