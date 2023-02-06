# ZSH Git Prompt Plugin from:
# https://github.com/olivierverdier/zsh-git-prompt

## Hook function definitions
function saml2aws_update()
{
  if [ -e ~/.aws/default_role ] ; then
    source ~/.aws/default_role
    export AWS_PROFILE=${AWS_PROFILE}
  else
    saml-role
  fi
  saml-login
}

saml-login() {
  saml2aws login --skip-prompt $*
  if [ $? -ne 0 ] ; then
    rm -f source ~/.aws/default_role
  fi
}

saml-refresh() {
  set -x
  echo "Refreshing role list"
  echo "Check OKTA app in your secondary device"
  if [ ! -e ~/.aws ] ; then
    mkdir ~/.aws
  fi
  saml2aws list-roles --skip-prompt > ~/.aws/roles.new
  grep ^arn ~/.aws/roles.new > ~/.aws/roles
  ls -al ~/.aws/roles*
  set +x
}

saml-role () {
  if [ ! -e $HOME/.aws/roles ] ; then
     saml-refresh
  fi
  if [ -z $1 ] ; then
    ROLE=$(cat $HOME/.aws/roles | fzf --header='Select your AWS profile')
  else
    ROLE=$(cat $HOME/.aws/roles | fzf --header='Select your AWS profile' -1 -q $1)
  fi

  if [ $? -eq 127 ] ; then
     echo "You need to install 'percol' to use saml-role"
  else
    if [ -z ${ROLE} ] ; then
      echo "No Profile Selected"
    else
      export SAML2AWS_ROLE=${ROLE}
      export AWS_PROFILE=$(echo ${SAML2AWS_ROLE} | awk -F: '{print $5 ":" $6}')
      export AWS_REGION=${SAML2AWS_REGION}
      export SAML2AWS_PROFILE=$AWS_PROFILE
      echo "SAML2AWS_ROLE=${SAML2AWS_ROLE}" > ~/.aws/default_role
      echo "AWS_PROFILE=${AWS_PROFILE}" >> ~/.aws/default_role
      echo "SAML2AWS_PROFILE=${SAML2AWS_PROFILE}" >> ~/.aws/default_role
      saml-login
    fi
  fi
}

#function okta_prompt_info() {
#  [[ -z $OKTA_PROFILE ]] && return
#  RPROMPT="${ZSH_THEME_AWS_PREFIX:=<okta:}${OKTA_PROFILE}${ZSH_THEME_AWS_SUFFIX:=>}"
#
#}
#precmd_functions+=(saml2aws_update)
#preexec_functions+=(saml2aws_update)
