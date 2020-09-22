# Install projects

```bash
$ git clone https://github.com/Mirocow/docker-develop.git
$ cd docker-develop
$ git submodule update --remote
$ cp .env.sample .env
```

# Start/Stop proxy

```bash
$ bash start.sh
$ bash stop.sh
```

# Docker manager Portainer

http://127.0.0.1:8080/
* login: admin
* password: password

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
|   ├── MariaDB  3307
|   └── PHP7.2   9002
├── yii3-app.loc            - Yii3 advanced project
|   ├── MariaDB  3308
|   └── PHP7.4   9003
├── yii3-demo.loc            - Yii3 advanced project
|   ├── MariaDB  3309
|   └── PHP7.4   9004
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
$ bash stop.sh && bash start.sh
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && composer install'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && php ./init --env=Development --overwrite=y'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && php ./yii migrate/up --interactive=0'
$ docker-compose -f yii2-app.loc.yml exec -T php_yii2_app /bin/bash -c 'cd /app && git config core.fileMode false'
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

## Yii3 Applications

### Develop

```bash
$ bash stop.sh && bash start.sh
$ docker-compose -f yii3-app.loc.yml up -d
$ docker-compose -f yii3-app.loc.yml exec -T php_yii3_app /bin/bash -c 'cd /app && rm .gitignore && composer create-project --prefer-dist --stability=dev yiisoft/app ./'
$ docker-compose -f yii3-app.loc.yml exec -T php_yii3_app /bin/bash -c 'cd /app && composer install'
$ docker-compose -f yii3-app.loc.yml exec -T php_yii3_app /bin/bash -c 'cd /app && php ./vendor/bin/yii'
$ docker-compose -f yii3-app.loc.yml exec -T php_yii3_app /bin/bash -c 'cd /app && git config core.fileMode false'
```

### With debug

```bash
$ docker-compose -f yii3-app.loc.yml -f docker-compose-yii3-app-xdebug.yml up -d
```

### Test

```bash
$ docker-compose -f yii3-app.loc.yml up -d
$ docker-compose -f yii3-app.loc.yml exec -T php_yii3_app /bin/bash -c 'cd /app/common/tests && php ./bin/yii migrate/up --interactive=0'
```

## Yii3 demo Applications

### Develop

```bash
$ bash stop.sh && bash start.sh
$ docker-compose -f yii3-demo.loc.yml up -d
$ docker-compose -f yii3-demo.loc.yml exec -T php_yii3_demo /bin/bash -c 'cd /app && rm .gitignore && git clone https://github.com/yiisoft/yii-demo.git ./'
$ docker-compose -f yii3-demo.loc.yml exec -T php_yii3_demo /bin/bash -c 'cd /app && composer install'
$ docker-compose -f yii3-demo.loc.yml exec -T php_yii3_demo /bin/bash -c 'cd /app && php ./vendor/bin/yii'
$ docker-compose -f yii3-demo.loc.yml exec -T php_yii3_demo /bin/bash -c 'cd /app && git config core.fileMode false'
```

### With debug

```bash
$ docker-compose -f yii3-demo.loc.yml -f docker-compose-yii3-demo-xdebug.yml up -d
```

### Test

```bash
$ docker-compose -f yii3-demo.loc.yml up -d
$ docker-compose -f yii3-demo.loc.yml exec -T php_yii3_demo /bin/bash -c 'cd /app/common/tests && php ./bin/yii migrate/up --interactive=0'
```

### Added custom nginx modules

#### Documentation

* https://romden.me/debian/nginx/devops/sysadm/nginx-add-modules/
* https://dermanov.ru/exp/configure-push-and-pull-module-for-bitrix24/
* https://habr.com/ru/company/cackle/blog/167895/
* https://www.nginx.com/resources/wiki/modules/push_stream/
* https://github.com/LoicMahieu/alpine-nginx/blob/master/Dockerfile
* https://www.linux.org.ru/forum/admin/13200380
* https://dev.1c-bitrix.ru/support/forum/forum23/topic62672/
* https://www.nginx.com/blog/compiling-dynamic-modules-nginx-plus/#load_module

#### Nginx modules

* https://github.com/wandenberg/nginx-push-stream-module

