docker build -t jms-consumer:latest $DIR
if [ $? -ne 0 ];then
   echo "EXIT STATUS: Could not build docker image for consumer"
   exit 1
fi
