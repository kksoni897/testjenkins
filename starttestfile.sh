#!/bin/bash
echo "***************Deployment Script Started************************"
cp mydir.tar /home/krishna/deploy/
cd /home/krishna/deploy/
tar -zxvf mydir.tar
cd /home/krishna/deploy/
. /home/krishna/softwares/anaconda3/bin/activate base
hostPort=0.0.0.0:9020
processToKillOnPort=[9]020
processName=test:app
echo "Anaconda environment setup is done at `pwd`"
cd $pathToSyntactic
nohup gunicorn -w 1 --threads=12 -b $hostPort -p pidfile $processName > scriptOut.text 2>&1 &
pid=$!
echo "new PID $pid"
status=true
time=0
while $status
    do
        echo "checking api..."
        response=$(curl -s -o /dev/null -w "%{http_code}\n" http://$hostPort/test --connect-timeout 2)
        if [ $response -eq 200 ]; then
            status=false
        fi
        echo "Response is : $response"
        sleep 2
        time=`expr $time + 2`
        if [ $time -eq 10 ]; then
            cat scriptOut.text
            exit 1
            break
        fi
    done
cat scriptOut.text
