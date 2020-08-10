# Start/Stop proxy

```bash
$ bash start.sh
$ bash stop.sh
```

# Projects and configurations

```
├── data
│   ├── dnsmasq - Зоны
│   └── nginx - Базовые настройки для сервера
├── hosts
│   └── yii2-app.loc
│       ├── etc
│       │   └── nginx
│       │       └── default.conf
│       └── httpdocs
├── provision
│   ├── apache_php
│   ├── dnsmasq
│   ├── elasticsearch
│   ├── generator
│   ├── kibana
│   ├── mariadb
│   ├── nginx
│   ├── php
│   ├── postgres
│   ├── proxy
│   ├── rabbitmq
│   ├── redis
│   └── templates
└── scripts
```

# Ports
```
├── yii2-app.loc            - Yii2 advanced project
|   ├── MariaDB  3306
|   └── PHP7.2   9002
├── Other projects
```

# Preparing

```bash
$ sudo ifconfig eno1:0 10.254.254.254 up
$ sudo ifconfig en0 alias 10.254.254.254 255.255.255.0 (MAC OS)
```

# Install and upgrade

## Yii2 Applications

### Develop

```bash
$ docker-compose -f yii2-app.loc.yml up -d
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && composer install'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && php ./init --env=Development --overwrite=y'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && php ./yii migrate/up --interactive=0'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && git config core.fileMode false'
$ bash stop.sh && bash start.sh
```

### With debug

```bash
$ docker-compose -f yii2-app.loc.yml -f docker-compose-yii2-app-xdebug.yml up -d
```

### Test

```bash
$ docker-compose -f yii2-app.loc.yml up -d
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app/common/tests && php ./bin/yii migrate/up --interactive=0'
```



