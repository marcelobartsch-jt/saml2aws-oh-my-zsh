This is a oh-my-zsh plugin for saml2aws

Make sure you have installed aws-okta program (OSX: `brew install saml2aws`, Linux: download the binary)
you need to create the following directory
`$HOME/.oh-my-zsh/custom/plugins/saml2aws/`

Then download the file plugin/saml2aws/saml2aws.plugin.zsh and put in on

`$HOME/.oh-my-zsh/custom/plugins/saml2aws/saml2aws.plugin.zsh`

give execution permissions `chmod +x $HOME/.oh-my-zsh/custom/plugins/saml2aws/saml2aws.plugin.zsh`

and add `saml2aws` to the _plugins_ variable inside `~/.zshrc` for the plugin to load, then reload your shell.

Recommended Variables:
* SAML2AWS_SESSION_DURATION: set it to 28800 if possible
* SAML2AWS_ROLE: default AWS role to use

*Good luck!*

