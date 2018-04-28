export MAVEN_OPTS='-Xmx1024m'
complete -C $PROFILE_WORKING_PATH/scripts/ant-completion.pl ant build.sh

# http://stackoverflow.com/questions/1348842/what-should-i-set-java-home-to-on-osx
if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi
