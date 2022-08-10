
SERVICES_DIR="/usr/lib/systemd/system"
CONSUL_API_URL="127.0.0.1:8500/v1/agent/service/register"

register_nginx_to_consul() {
    curl -XPUT "${CONSUL_API_URL}?replace-existing-checks=true" -d '{
        "Name": "nginx-consul",
        "Address": "127.0.0.1",
        "Port": 80,
        "Meta": {},
        "EnableTagOverride": false,
        "Check": {
            "DeregisterCriticalServiceAfter": "30m",
            "HTTP": "/",
            "Interval": "20s",
            "Timeout": "5s"
        },
        "Weights": {
            "Passing": 10,
            "Warning": 1
        }
    }'
}

setup_service() {
    cp -f ./services/${1}.service ${SERVICES_DIR}/${1}.service
    systemctl enable ${SERVICES_DIR}/${1}.service
    service ${1} start
}

setup_docker() {
    which docker || {
        amazon-linux-extras install docker
        systemctl enable docker.service
        service docker start
    }
}

setup_proxy() {
    setup_docker;
    setup_service consul-agent;
    setup_service nginx-consul;

    sleep 5;
    register_nginx_to_consul;
}

setup_worker() {
    setup_docker;
    setup_service consul-agent;
    setup_service nomad-agent;
}

setup_master() {
    echo "TO BE IMPLEMENTED";
    exit 128;
}