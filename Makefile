#
#
#
#

run:
	./node_modules/grunt-cli/bin/grunt compile
	./node_modules/http-server/bin/http-server _app

watch:
	./node_modules/grunt-cli/bin/grunt watch
