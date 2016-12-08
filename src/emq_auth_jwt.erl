-module(emq_auth_jwt).

-behaviour(emqttd_auth_mod).

-include_lib("emqttd/include/emqttd.hrl").

-export([init/1, check/3, description/0]).

-define(UNDEFINED(S), (S =:= undefined orelse S =:= <<>>)).

-define(SECRET, <<"secret">>).

init(Opts) -> {ok, Opts}.

check(#mqtt_client{username = Username}, Password, _Opts) when ?UNDEFINED(Username); ?UNDEFINED(Password)  ->
    {error, username_or_token_undefined};

check(#mqtt_client{client_id = ClientId, username = Username}, Password, _Opts)  ->
    io:format("Auth jwt: clientId=~p, username=~p, password=~p~n",
              [ClientId, Username, Password]),
    jwt:decode(Password, ?SECRET)
    % case jwt:decode(Password, ?SECRET) of
    %     {error, invalid_token} -> io:format("invalid_token"), {error, "invalid_token"};
    %     {error, invalid_signature} -> io:format("invalid_signature"), {error, "invalid_signature"};
    %     {error, expired} -> io:format("invalid_signature"), {error, "invalid_signature"};
    %     {ok, claimsJSON} -> io:format("claimsJSON"), {ok, "claimsJSON"}
    end.

description() -> "Auth jwt Module".