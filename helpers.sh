
SERVICES_DIR="/usr/lib/systemd/system"

register_nginx_to_consul() {
    curl -XPUT 127.0.0.1:8500/v1/agent/service/register -d '{
        "Name": "nginx-consul",
        "Address": "127.0.0.1",
        "Port": 80,
        "Meta": {},
        "EnableTagOverride": false,
        "Check": {
            "DeregisterCriticalServiceAfter": "30m",
            "Args": ["curl", "127.0.0.1:80"],
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
    stat ./services/${1}.service 2 > /dev/null && cp -f ./services/${1}.service ${SERVICES_DIR}/${1}.service
    systemctl enable ${SERVICES_DIR}/${1}.service
    service ${1} start
}

setup_base_services() {
    amazon-linux-extras install docker
    setup_service docker;
}