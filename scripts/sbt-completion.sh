# for sbt: http://code.google.com/p/simple-build-tool/

_sbt_complete() {
  local cur goals

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  goals="clean clean-cache clean-lib clean-plugins compile console console-quick"
  goals="$goals copy-resources copy-test-resources deliver deliver-local"
  goals="$goals doc doc-all doc-test exec graph-pkg graph-src increment-version"
  goals="$goals javap make-pom package package-all package-docs package-project"
  goals="$goals package-src package-test package-test-src publish publish-local"
  goals="$goals release run sh test test-compile test-failed test-javap test-only"
  goals="$goals test-quick test-run update"
  cur=`echo $cur | sed 's/\\\\//g'`
  COMPREPLY=($(compgen -W "${goals}" "${cur}" | sed 's/\\\\//g') )
}

complete -F _sbt_complete -o filenames sbt
