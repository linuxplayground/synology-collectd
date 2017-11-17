# Container Description
This container collects data from the synlolgy SNMP public community and pushes metrics into Graphite.

TODO: Expose variables so that they can be configured at run time.  This very _alpha_ release simply uses a templating engine to build the configuration which is baked into the container.  The next step is to stop doing that and move this functionality into the `entrypoint.sh` script.

# Requirements
* python 3.5 or python 3.6
* python virtualenv

# Build
* Configure the settings in `make_env`
* `make build`

# Test
* `make run`

