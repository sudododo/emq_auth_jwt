-module(emq_auth_jwt_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = emq_auth_jwt_sup:start_link(),
    ok = emqttd_access_control:register_mod(auth, emq_auth_jwt, []),
    ok = emqttd_access_control:register_mod(acl, emq_acl_jwt, []),
    emq_plugin_template:load(application:get_all_env()),
    {ok, Sup}.

stop(_State) ->
    ok = emqttd_access_control:unregister_mod(auth, emq_auth_jwt),
    ok = emqttd_access_control:unregister_mod(acl, emq_acl_jwt),
    emq_plugin_template:unload().