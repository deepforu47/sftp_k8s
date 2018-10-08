#!/bin/bash
#set -e

# if $proxy_domain is not set, then default to $HOSTNAME
#export proxy_domain=${proxy_domain:-$HOSTNAME}

# ensure the following environment variables are set. exit script and container if not set.
#test $backend_host
#test $load_balancer_domain
#test $app_servers
test $allowed_users
test $allowed_groups

echo "Check for env variables - $allowed_users and $allowed_groups"

## Actual Script
#!/bin/bash
# Add users
IFS=',' read -a users <<< "$SFTP_USERS"
sftpgroup=appuser
for userData in "${users[@]}";do

   IFS=':' read -a data <<< "$userData"
   user="${data[0]}"
   pass="${data[1]}"

   if [ "${data[2]}" == "e" ]; then
      encrypted=yes
      uid="${data[3]}"
      elif [ ${data[2]} ]; then
           uid="${data[2]}"
   fi

    if ! [ $uid ]; then
      uid=$(shuf -i 1500-2000 -n 1)
    fi
    sudo useradd -u $uid $user
    sudo usermod -aG $sftpgroup $user

    if [ "$encrypted" == "yes" ]; then
      echo "$user:$pass" | chpasswd -e
    else
      echo "$user:$pass" | chpasswd
    fi

    sudo mkdir -p /home/$user/.ssh
    yes |cp /tmp/authorized_keys /home/$user/.ssh/ && echo ""
    sudo chown -R $user:$user /home/$user/.ssh
    sudo chown root:root /home/$user
    sudo chmod 755 /home/$user
    sudo chmod 700 /home/$user/.ssh
    sudo chmod 600 /home/$user/.ssh/authorized_keys
done
# Remove tmp data from /tmp
sudo rm -rf /tmp/* && touch /tmp/test_kubectl

# Run SSH
sudo mkdir /var/run/sshd
sudo /usr/local/bin/confd -onetime -backend env

echo "sFTP Testing"
#/bin/bash
sudo /usr/sbin/sshd -D -f /etc/ssh/sshd_config
cat /etc/ssh/sshd_config
######################