-module(todo_home_controller, [Req, SessionId]).
-compile(export_all).

home('GET', []) ->
	Timestamp = boss_mq:now("updates"),
	{ok, [{timestamp, Timestamp}]}.

