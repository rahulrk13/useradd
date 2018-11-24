u=$1
n=$(grep $u /etc/passwd | wc -l)

#if [ grep "testuser1" /etc/passwd | wc -l > 0 ]
echo $u
if [ $n = 0 ]
then
   echo "New User detected"
else
   echo "User exist"
fi
