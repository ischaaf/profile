#!/usr/bin/env bash

BP="$(brew --prefix)"

# asciidoc, docbook
export XML_CATALOG_FILES="$BP/etc/xml/catalog"

# libxslt
# gem install nokogiri -- --with-xslt-dir=/home/linuxbrew/.linuxbrew/opt/libxslt

# node
# /home/linuxbrew/.linuxbrew/etc/bash_completion.d

# perl
# By default non-brewed cpan modules are installed to the Cellar. If you wish
# for your modules to persist across updates we recommend using `local::lib`.
#
# You can set that up like this:
#   PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
#   echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> ~/.bash_profile

