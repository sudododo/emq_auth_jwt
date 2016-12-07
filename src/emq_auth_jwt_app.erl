-module(emq_auth_jwt_app).

-behaviour(application).

%% Application callbacks
-export([start/2, prep_stop/1, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_auth_jwt_sup:start_link(),
    emqttd_access_control:register_mod(auth, emq_auth_jwt),
    emqttd_access_control:register_mod(acl, emq_acl_jwt),
    {ok, Sup}.

prep_stop(State) ->
    emqttd_access_control:unregister_mod(acl, emq_acl_jwt),
    emqttd_access_control:unregister_mod(auth, emq_auth_jwt),
    State.

stop(_State) ->
    ok.