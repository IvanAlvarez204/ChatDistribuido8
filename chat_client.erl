-module(chat_client).
-export([start/1,recibe/2]).

start(Name) ->
    register(Name, self()),
    {chat_server, 'server@LAPTOP-VDJ5RA56'} ! {connect, node(self())},
    io:format("~p has joined the chat.~n", [Name]),

    spawn(node(self()),fun() -> listen_for_messages() end),
    loop_send(Name).

listen_for_messages() ->
    
    receive
        {recibe,From, Message} ->
            io:format("kmr,klfmerl "),
            recibe(From, Message),
            listen_for_messages();
        _Other ->
            io:format("Mensaje no reconocido, esperando de nuevo.~n"),
            listen_for_messages()
    end.

loop_send(Name) ->
    io:format("Type a message: ", []),
    Message = io:get_line(""),
    {chat_server, 'server@LAPTOP-VDJ5RA56'} ! {send, Name,Message},
    loop_send(Name).

recibe(From, Message) ->
    chat_client ! {recibe, From, Message},
    io:format("a1a1a1.~n").