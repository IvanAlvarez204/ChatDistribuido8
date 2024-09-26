-module(chat_server).
-export([start/0, stop/0, send/2,connect/1,disconnect/1,loop/1]).

start() ->
    register(chat_server, spawn(node(self()),fun() -> loop([]) end)),
    io:format("Chat server started.~n").

stop() ->
    unregister(chat_server),
    io:format("Chat server stopped.~n").

loop(Users) ->
    receive
        {send, From, Message} ->
            io:format("~p: ~s~n", [From, Message]),
            broadcast(Users, From, Message),
            loop(Users);
        {connect, User} ->
            io:format("~p connected:.~n", [User]),
            loop([{User} | Users]);
        {disconnect, User} ->
            io:format("~p disconnected.~n", [User]),
            loop(Users -- [User])
    end.

broadcast([], _From, _Message) -> ok;
broadcast([{User} | Rest], From, Message) ->
    %{User} ! {recibe, From, Message},
    {chat_client,User} ! {recibe,From, Message},
    broadcast(Rest, From, Message).

send(From, Message) ->
    chat_server ! {send, From, Message}.

connect(User) ->
    chat_server ! {connect, User}.

disconnect(User) ->
    chat_server ! {disconnect, User}.