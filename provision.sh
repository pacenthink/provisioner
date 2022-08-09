#!/usr/bin/env bash

set -e 

source ./helpers.sh;

setup_base_services;

setup_service consul;
setup_service nginx-consul;

register_nginx_to_consul;