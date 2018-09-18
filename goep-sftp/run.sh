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
    useradd -u $uid $user
    usermod -aG $sftpgroup $user

    if [ "$encrypted" == "yes" ]; then
      echo "$user:$pass" | chpasswd -e
    else
      echo "$user:$pass" | chpasswd
    fi
       
    mkdir /home/$user/.ssh 
    yes |cp /tmp/authorized_keys /home/$user/.ssh/ && echo "" 
    chown -R $user:$user /home/$user/.ssh 
    chown root:root /home/$user 
    chmod 755 /home/$user 
    chmod 700 /home/$user/.ssh 
    chmod 600 /home/$user/.ssh/authorized_keys 
done
# Remove tmp data from /tmp
rm -rf /tmp/*

# Run SSH
/usr/sbin/sshd -D -f /etc/ssh/sshd_config