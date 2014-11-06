#!/bin/sh
echo "===================================================="
echo "      << Simple localrc generator tool >>           "
echo ""
echo "  This script assumes that you are using eth0 as    "
echo "    NAT and eth1 as Host-only configuration in      "
echo "    your installed VirtualBox environment.          "
echo "  The initial password will be 'openstack' for      "
echo "    'admin' and 'demo' users.                       "
echo ""
echo "  * Warning: This script will overwrite your        "
echo "    previous localrc file. So please backup         "
echo "    it if you already have localrc file.            "
echo "                                                    "
echo "                  Made by Ian Y. Choi, Nov 2014     "
echo "===================================================="
echo -n "Press ENTER to continue (quit: Ctrl+C) "
read NUL
echo ""

# We need to specify the target of host adapter (assuming eth1).
HOST_ETH="eth1"

# Error check
/sbin/ifconfig $HOST_ETH > /dev/null 2>&1
if [ "$?" -ne "0" ]; then
  echo " * ERROR: Please check your eth1 adapter!"
  echo ""
  exit 1
fi

# Retrieve the IP address for HOST_ETH
HOST_IP=`/sbin/ifconfig $HOST_ETH | grep "inet addr" | awk '{print $2}' | cut -f 2 -d :`

# Write localrc
echo "HOST_IP=$HOST_IP" > localrc
echo "PUBLIC_INTERFACE=eth0

# Logging
DEST=/opt/stack
LOGFILE=$DEST/logs/stack.sh.log
SCREEN_LOGDIR=$DEST/logs/screen

# Credentials
ADMIN_PASSWORD=openstack
MYSQL_PASSWORD=openstack
RABBIT_PASSWORD=openstack
SERVICE_PASSWORD=openstack
SERVICE_TOKEN=tokentoken

# Neutron - Networking Service
DISABLED_SERVICES=n-net
ENABLED_SERVICES+=,q-svc,q-agt,q-dhcp,q-l3,q-meta,q-metering,neutron

" >> localrc

# Exit message
echo " * Successfully created localrc file. Thank you!"
echo ""
