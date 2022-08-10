#!/usr/bin/env bash

set -e

source ./helpers.sh;

case $1 in

  proxy)
    setup_proxy
    ;;

  worker)
    setup_worker
    ;;

  master)
    setup_master
    ;;

  *)
    echo "Role not supported: $1";
    exit 1;
    ;;
esac