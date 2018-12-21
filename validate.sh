user_count=$(jq '. | length' newuser.json)
echo $user_count
loop_count=0

while [ $loop_count -lt $user_count ]
do
        user_name=$(jq '.'[$loop_count] newuser.json | tr -d "\"")
        echo $user_name
        #echo "Current user name $user_name"
        n=$(grep $user_name /etc/passwd | wc -l)
        if [ $n -gt 0 ]
        then
                echo "User exist :$user_name"
        else
                echo "New User detected: $user_name"
               # echo "Do you want to add this user (y/n)"
               # read a
               # if [ $a == "y" ]
               echo "Adding user $user_name"
	       # then
                     #   echo "You selected Yes, Adding new user now"
                        useradd -s /bin/bash -m $user_name
                        #passwd $user_name
			echo "New User \"$user_name\" was added Successfully! Deploying public keys for ssh access..."
                        [ -f ./public_keys/$user_name.pub ] && echo "Public keys exists" || echo "Public keys were not found"
		       	mkdir /home/$user_name/.ssh
                        cp ./public_keys/$user_name.pub /home/$user_name/.ssh/authorized_keys
                        chown -R $user_name:$user_name /home/$user_name
                        echo "Public keys uploaded successfully!"
                        echo "___________________________"
			# else
                #        echo "You selected no"
               # fi
        
        fi
        loop_count=`expr $loop_count + 1`
done

echo "
User Validation complete!"
