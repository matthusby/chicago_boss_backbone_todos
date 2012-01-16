-module(todo, [Id, Text, Order, Done]).
-compile(export_all).

after_create() ->
	boss_mq:push("updates", THIS).

after_update() ->
	boss_mq:push("updates", THIS).

