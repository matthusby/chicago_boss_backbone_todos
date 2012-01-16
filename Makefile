ERL=erl
APP=todo

all:
	$(ERL) -pa /Users/matthusby/Desktop/todos/ChicagoBoss/ebin -eval 'boss_load:load_all_modules_and_emit_app_file($(APP), "ebin")' -s init stop -noshell

clean:
	rm -fv ebin/*.beam
	rm -fv ebin/$(APP).app
	
update_po:
	$(ERL) -pa ebin -pa ../ChicagoBoss/ebin -eval 'boss_load:load_models("ebin")' -eval 'boss_lang:update_po()' -s init stop -noshell

.PHONY: test
test:
	$(ERL) -pa $(PWD)/ebin -pa /Users/matthusby/Desktop/todos/ChicagoBoss/ebin -run boss_web_test start $(APP) -noshell
