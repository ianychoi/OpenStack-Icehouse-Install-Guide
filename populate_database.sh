#!/bin/sh
#
# Populate database initial configuration to MySQL
#
# Description: Fill MySQL with data

# Mainly inspired by
#  - https://github.com/fornyx/OpenStack-Havana-Install-Guide/blob/master/populate_database.sh
#
# Originally Written by Andriy Yurchuk (https://github.com/Ch00k)
# Contributors: Andriy Yurchuk
#               Ian Y. Choi / NAIM Networks
#
# License: Apache Software License (ASL) 2.0
#


echo -n "MYSQL_PASSWORD: "
read MYSQL_PASSWORD 

mysql -u root -p${MYSQL_PASSWORD} << EOF

-- Keystone

CREATE DATABASE keystone;
GRANT ALL ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
FLUSH PRIVILEGES;

-- Glance
CREATE DATABASE glance;
GRANT ALL ON glance.* TO 'glance'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON glance.* TO 'glance'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Neutron

CREATE DATABASE neutron;
GRANT ALL ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON neutron.* TO 'neutron'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Nova
CREATE DATABASE nova;
GRANT ALL ON nova.* TO 'nova'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON nova.* TO 'nova'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Cinder
CREATE DATABASE cinder;
GRANT ALL ON cinder.* TO 'cinder'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON cinder.* TO 'cinder'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Heat
CREATE DATABASE heat;
GRANT ALL ON heat.* TO 'heat'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON heat.* TO 'heat'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Trove
CREATE DATABASE trove;
GRANT ALL ON trove.* TO 'trove'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL ON trove.* TO 'trove'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

FLUSH PRIVILEGES;
EOF
