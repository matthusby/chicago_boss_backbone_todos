-module(todo_poll_controller, [Req, SessionId]).
-compile(export_all).

getUpdate('GET', [LastTimestamp]) ->
	{ok, Timestamp, Objects} = boss_mq:pull("updates", list_to_integer(LastTimestamp)),
	{json, [{timestamp, Timestamp}, {objects, Objects}]}.

