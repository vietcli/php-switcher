#!/usr/bin/env bash

if [ "$(whoami)" != 'root' ];
then
    echo $"You have no permission to run $0 as non-root user. Use sudo"
    exit 1;
fi

if ! type php >/dev/null 2>&1; then
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.0 php5.6 php7.0-common php5.6-common php5.6-mysql php-gettext php5.6-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0 \
php5.6-bcmath php7.0-bcmath php5.6-curl php7.0-curl php5.6-gd php7.0-gd php5.6-intl php7.0-intl php5.6-mbstring php7.0-mbstring \
php5.6-mcrypt php7.0-mcrypt php5.6-mysql php7.0-mysql php5.6-soap php7.0-soap php5.6-dom php7.0-dom php5.6-xml php7.0-xml php5.6-xsl php7.0-xsl php5.6-zip php7.0-zip	php7.0-bz2 php5.6-bz2

fi

### Set default parameters
version=$1

if [ "$version" != '5.6' ] && [ "$version" != '7.0' ]; then
    echo $"You need to prompt for version (5.6, 7.0)"
    exit 1;
fi

if [ "$version" == '5.6' ]
then
    sudo phpdismod php7.0 2> /dev/null
    sudo phpenmod php5.6 2> /dev/null
    sudo ln -sfn /usr/bin/php5.6 /etc/alternatives/php

elif [ "$version" == '7.0' ]
then
    sudo phpdismod php7.0 2> /dev/null
    sudo phpenmod php5.6 2> /dev/null
    sudo ln -sfn /usr/bin/php7.0 /etc/alternatives/php

fi

if type apache2 >/dev/null 2>&1; then
    sudo service apache2 restart;
fi

if type nginx >/dev/null 2>&1; then
    sudo service nginx restart;
fi

