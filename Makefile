SHELL=/bin/bash
export PATH := ./bin:./venv/bin:$(PATH)
PYTHON ?= $(shell command -v python3.5 || command -v python3.6)

include make_env
default: build

build: config
	docker build -t  $(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) .

run:
	docker \
		--name $(DOCKER_IMAGE_NAME)-default \
		--rm -it \
		$(DOCKER_NAMESPACE)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)

kill:
	docker kill $(DOCKER_IMAGE_NAME)-default

venv: requirements.txt
	test -d venv || virtualenv --python=$(PYTHON) venv
	pip install -r requirements.txt
	touch venv

clean:
	rm -f config/*

config: venv clean
	jinja2 \
		-D graphite_ip_address='$(GRAPHITE_IP_ADDRESS)' \
		-D graphite_tcp_port='$(GRAPHITE_TCP_PORT)' \
		templates/collectd.conf.j2 > config/collectd.conf
	jinja2 \
		-D synology_ip_address='$(SYNOLOGY_IP_ADDRESS)' \
		-D synology_snmp_community='$(SYNOLOGY_SNMP_COMMUNITY)' \
		templates/synology.conf.j2 > config/synology.conf

