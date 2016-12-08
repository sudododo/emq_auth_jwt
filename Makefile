PROJECT = emq_auth_jwt
PROJECT_DESCRIPTION = emqtt auth jwt
PROJECT_VERSION = 2.0.1

DEPS = jwt
dep_jwt = git https://github.com/sudododo/jwt master

BUILD_DEPS = emqttd
dep_emqttd = git https://github.com/emqtt/emqttd master

TEST_DEPS = cuttlefish
dep_cuttlefish = git https://github.com/emqtt/cuttlefish

COVER = true

include erlang.mk

app:: rebar.config

app.config::
	cuttlefish -l info -e etc/ -c etc/emq_plugin_template.conf -i priv/emq_plugin_template.schema -d data