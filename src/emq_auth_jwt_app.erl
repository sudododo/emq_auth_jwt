-module(emq_auth_jwt_app).

-include("emq_auth_jwt.hrl").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_auth_jwt_sup:start_link(),
    if_enabled(fun reg_authmod/0),
    if_enabled(fun reg_aclmod/0),
    {ok, Sup}.

prep_stop(State) ->
    emqttd_access_control:unregister_mod(acl, emq_acl_jwt),
    emqttd_access_control:unregister_mod(auth, emq_auth_jwt),
    State.

stop(_State) ->
    ok.

reg_authmod() ->
    emqttd_access_control:register_mod(auth, emq_auth_jwt, Opts).

reg_aclmod() ->
    emqttd_access_control:register_mod(acl, emq_acl_jwt, Opts).