complete -C $PROFILE_WORKING_PATH/scripts/rake_and_cap_completion.rb -o default rake
complete -C $PROFILE_WORKING_PATH/scripts/rake_and_cap_completion.rb -o default cap

export RSPEC=true

alias sc='./script/console'

if [[ -s "${HOME}/.rvm/scripts/rvm" ]] ; then source "${HOME}/.rvm/scripts/rvm" ; fi
