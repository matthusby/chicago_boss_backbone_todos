#!/bin/sh
cd `dirname $0`
exec erl -pa $PWD/ebin \
     -pa /Users/matthusby/Desktop/todos/ChicagoBoss/ebin \
     -pa /Users/matthusby/Desktop/todos/ChicagoBoss/deps/*/ebin \
     -boss developing_app todo \
     -boot start_sasl -config boss -s reloader -s boss \
     -sname wildbill
