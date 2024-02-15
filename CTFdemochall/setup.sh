#!/bin/bash

apt-get install xinetd

user=anotherarena
binary=anotherarena
port=31335

useradd $user
mkdir /home/$user
cp $binary /home/$user/
chown -R root:root /home/$user
chown root:$user /home/$user/$binary
chmod 2755 /home/$user/$binary

echo "quarkCTF{Buff3r_0v3rfl0w_f1x_cr4ckm3}" > /home/$user/flag
chown root:$user /home/$user/flag && chmod 440 /home/$user/flag;

cat <<EOF > /etc/xinetd.d/$user
service $user
{
    disable = no
    socket_type = stream
    protocol    = tcp
    wait        = no
    user        = $user
    bind        = 0.0.0.0
    server      = /home/$user/$binary
    type        = UNLISTED
    port        = $port
    flags = REUSE
    per_source = 5
    rlimit_cpu = 3
    nice = 18
}
EOF

service xinetd restart