-module(emq_auth_jwt_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-behaviour(supervisor).

-define(APP, emq_auth_jwt).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_auth_jwt_sup:start_link(),
    ok = emqttd_access_control:register_mod(auth, emq_auth_jwt, []),
    ok = emqttd_access_control:register_mod(acl, emq_acl_jwt, []),
    {ok, Sup}.

stop(_State) ->
    ok = emqttd_access_control:unregister_mod(auth, emq_auth_jwt),
    ok = emqttd_access_control:unregister_mod(acl, emq_acl_jwt).