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

    chown -R $user:$user /home/$user
    chmod 755 /home/$user
    chmod 0700 /home/$user/.ssh
    chmod 0600 /home/$user/.ssh/authorized_keys
done

# Run SSH
/usr/sbin/sshd -D