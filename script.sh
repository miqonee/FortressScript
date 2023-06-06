#!/bin/bash

# Включить обработку ошибок
set -euo pipefail

# Валидация ввода пользователя для порта SSH
function get_ssh_port {
    while true; do
        echo "Введите новый порт SSH: "
        read port
        if [[ $port =~ ^[0-9]+$ ]] && [ $port -ge 1 -a $port -le 65535 ]; then
            break
        else
            echo "Некорректный порт, пожалуйста, введите число от 1 до 65535."
        fi
    done
}

# Проверка доступа root
function check_root {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Пожалуйста, запустите как root"
        exit 1
    fi
}

# Логирование
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1

# Поддержка различных дистрибутивов Linux
function get_package_manager {
    if [ -f /etc/debian_version ]; then
        echo apt-get
    elif [ -f /etc/redhat-release ]; then
        echo yum
    elif [ -f /etc/arch-release ]; then
        echo pacman
    else
        echo "Неизвестный дистрибутив Linux."
        exit 1
    fi
}

# Использование функций
function install_package {
    PACKAGE_MANAGER=$(get_package_manager)
    $PACKAGE_MANAGER install $1 -y
}

# Использование массивов и циклов
function install_packages {
    packages=(fail2ban clamav clamav-daemon snort iptables-persistent lynis aide)
    for package in ${packages[@]}; do
        install_package $package
    done
}

# Более надежное добавление в crontab
function add_cron_job {
    (crontab -l 2>/dev/null; echo "0 0 * * * root clamscan --recursive / --exclude-dir=/sys/* --quiet --infected --move=/var/lib/clamav/quarantine | mail -s \"[ClamAV] Scan Results\" ${email}") | crontab -
}

# Проверка возвращаемого значения команд
function start_service {
    if ! systemctl start $1; then
        echo "Failed to start $1."
        exit 1
    fi
}

# Использование "тихого" режима
function set_verbose {
    if [ "${1}" != "--quiet" ]; then
        VERBOSE=1
    fi
}

# Обновление системы
function update_system {
    PACKAGE_MANAGER=$(get_package_manager)
    $PACKAGE_MANAGER update -y
    $PACKAGE_MANAGER upgrade -y
}

# Запрос веб-сервера
function ask_webserver {
    echo "У вас установлен Apache или Nginx? (apache/nginx)"
    read webserver
}

# Настройка Apache
function setup_apache {
    a2enmod headers
    a2enmod ssl
    a2enmod rewrite
    systemctl restart apache2
    echo "<IfModule mod_headers.c>
    Header set X-Content-Type-Options: \"nosniff\"
    Header set X-Frame-Options: \"sameorigin\"
    Header set X-XSS-Protection: \"1; mode=block\"
    Header always append X-Frame-Options SAMEORIGIN
    Header set X-Permitted-Cross-Domain-Policies: \"master-only\"
  </IfModule>" >> /etc/apache2/conf-enabled/security-headers.conf
  systemctl restart apache2
}

# Настройка Nginx
function setup_nginx {
  echo "server_tokens off;
  add_header X-Frame-Options SAMEORIGIN;
  add_header X-Content-Type-Options nosniff;
  add_header X-XSS-Protection \"1; mode=block\";
  add_header Content-Security-Policy \"default-src 'self'; script-src 'self'; img-src 'self'; style-src 'self';\";
  " >> /etc/nginx/conf.d/security.conf
  systemctl restart nginx
}

# Настройка веб-сервера
function setup_webserver {
    if [ "${webserver}" = "apache" ]; then
        setup_apache
    elif [ "${webserver}" = "nginx" ]; then
        setup_nginx
    else
        echo "Неизвестный веб-сервер. Пропускаем настройки веб-сервера."
    fi
}

# Главная функция
function main {
    check_root
    set_verbose $1
    update_system
    ask_webserver
    setup_webserver
    install_packages
    add_cron_job
    get_ssh_port
}

main $1
