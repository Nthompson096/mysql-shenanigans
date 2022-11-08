#!/bin/bash

if [ $EUID -ne 0 ]
	then
		echo "This program must run as root to function." 
		exit 1
fi

# to see if the service is already started

systemctl start mysql.service &&
echo "enter in ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password'; then enter/type in exit;"
mysql &&
echo "Keep in mind that you will need to enter this password I had just given you "
echo "for root, I would advise that you'd change it."
echo "resetting the mysql service..."
systemctl restart mysql.service --now &&
# mysql -u root -p &&

echo "ok you have now set up the service, now you'll need to "
# echo "mysql -u<ser> root -p<assword> enter the command"
# echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket; then enter/type in exit"
echo "continue the install with"
echo "sudo mysql_secure_installation"
