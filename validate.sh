u=$1
n=$(grep $u /etc/passwd | wc -l)

#if [ grep "testuser1" /etc/passwd | wc -l > 0 ]
echo $u
if [ $n = 0 ]
then
   echo "New User detected"
   echo "Do you want to add this user (y/n)"
   read a
   if [ $a == "y" ]
   then
        echo "You selected Yes, Adding new user now"
        useradd -s /bin/bash -m $1
        passwd $1
        echo "New User \"$1\" was added Successfully!"
   else
        echo "You selected no"     
   fi
else
   echo "User exist"
fi
