# for sbt: http://code.google.com/p/simple-build-tool/

_gem_complete() {
  local cur goals

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  goals="build cert check cleanup contents dependency environment fetch generate_index help install list lock mirror outdated owner pristine push query rdoc search server sources specification stale uninstall unpack update which"
  cur=`echo $cur | sed 's/\\\\//g'`
  COMPREPLY=($(compgen -W "${goals}" "${cur}" | sed 's/\\\\//g') )
}

complete -F _gem_complete -o filenames gem
