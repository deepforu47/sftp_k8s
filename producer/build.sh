docker build -t jms-producer:latest .
if [ $? -ne 0 ];then
   echo "EXIT STATUS: Could not build docker image for producer"
   exit 1
fi
