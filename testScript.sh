#!/bin/bash
echo "***************TestScriptStarted************************"
pathToSyntactic=$WORKSPACE
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
rm -rf PotentialNewOrchestrator
rm -rf Structure-*
cd $WORKSPACE
cd ..
rm -rf OrchestratorDeploy@tmp
kill -9 $pid
