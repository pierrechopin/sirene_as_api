#!/bin/sh
set -e
rm -f /docker_build/tmp/pids/server.pid
export RAILS_ENV=production
export HOST_SOLR_PORT=3000
bundle exec rake sunspot:solr:start
exec "$@"
