#!/bin/bash
function scptmp
{
    scp -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o "UserKnownHostsFile /dev/null" \
        "$@" > /dev/null 2>&1
}

function sshtmp
{
    ssh -o "ConnectTimeout 3" \
        -o "StrictHostKeyChecking no" \
        -o"UserKnownHostsFile /dev/null" \
        "$@" > /dev/null 2>&1
}



ips=$(gcloud compute instances list | awk 'NR!=1 {print $5}')

for ip in $ips
do
  echo "Uploading benchmark scripts to: $ip"
  scptmp benchmark pidunden@$ip:/home/pidunden/benchmark
  echo "Starting benchmark"
  sshtmp pidunden@$ip -f 'chmod +x /home/pidunden/benchmark && bash /home/pidunden/benchmark' &
done
