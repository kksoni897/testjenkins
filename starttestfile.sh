#!/bin/bash
if [ -e "pidfile" ]; then
   PID=`cat pidfile`
   if kill `cat pidfile`; then
	while s=`ps -p $PID -o s=` && [[ "$s" && "$s" != 'Z' ]]; do sleep 1; done
    	gunicorn -w 4 --threads 12 -b 0.0.0.0:9020 -p pidfile -D test:app
   fi
else
    gunicorn -w 4 --threads 12 -b 0.0.0.0:9020 -p pidfile -D test:app
fi
echo "process started successfully"


