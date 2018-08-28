#!/bin/bash
# Add users
IFS=',' read -a users <<< "$SFTP_USERS"

for userData in "${users[@]}";do

   IFS=':' read -a data <<< "$userData"
    user="${data[0]}"
    pass="${data[1]}"

   if [ "${data[3]}" == "e" ]; then
      encrypted=yes
      uid="${data[2]}"

          elif [ "${data[2]}" == "e" ]; then
                encrypted=yes
                elif [ ${data[2]} ]; then
                        uid="${data[2]}"
    fi

    if ! [ $uid ]; then
      uid=$(shuf -i 1500-2000 -n 1)
    fi

    useradd -u $uid $user

    if [ "$encrypted" == "yes" ]; then
      echo "$user:$pass" | chpasswd -e
    else
      echo "$user:$pass" | chpasswd
    fi
    
    mkdir /home/$user/.ssh 
    cp /tmp/authorized_keys /home/$user/.ssh/ 
    chown -R $user:$user /home/$user 
    chmod 755 /home/$user 
    chmod 700 /home/$user/.ssh 
    chmod 600 /home/$user/.ssh/authorized_keys
done

# Run SSH
/usr/sbin/sshd -D

#systemctl start sshd