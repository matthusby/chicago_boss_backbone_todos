-module(todo_todos_controller, [Req, SessionId]).
-compile(export_all).
-default_action(index).

index('GET', []) ->
	%% Get all of the todos and output a json list of them
	Todos = boss_db:find(todo,[]),
	{json, Todos};

index('POST', []) ->
	%% create a new Todo
	Json = mochijson2:decode(binary_to_list(Req:request_body())),
	Todo = boss_record:new(todo, [
		{id, id},
		{text, json:destructure("Obj.text", Json)},
		{order, json:destructure("Obj.order", Json)},
		{done, json:destructure("Obj.done", Json)}
	]),
	case Todo:save() of
		{ok, SavedTodo} ->
			{json, SavedTodo};
		{error, Error} ->
			{json, [{error, Error}]}
	end;

index('PUT', [Id]) ->
	%% Update an existing todo
	Json = mochijson2:decode(binary_to_list(Req:request_body())),
	Todo = boss_db:find(Id),
	UpdatedTodo = Todo:set([
		{text, json:destructure("Obj.text", Json)},
		{order, json:destructure("Obj.order", Json)},
		{done, json:destructure("Obj.done", Json)}		
	]),
	case UpdatedTodo:save() of
		{ok, SavedTodo} ->
			{json, SavedTodo};
		{error, Error} ->
			{json, [{error, Error}]}
	end;

index('DELETE', [Id]) ->
	%% Delete this todo
	Todo = boss_db:find(Id),
	boss_db:delete(Id),
	{json, Todo}.

