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


mtypes=(`gcloud compute instances list --format="table(MACHINE_TYPE)" | awk 'NR!=1'`)
ips=(`gcloud compute instances list --format="table(EXTERNAL_IP)" | awk 'NR!=1'`)

for i in "${!mtypes[@]}"; do 
  printf "Deploying to: %s\t%s\t%s\n" "$i" "${ips[$i]}" "${mtypes[0]}"
  ip=${ips[$i]}
  mtype=${mtypes[$i]}
  scptmp benchmark pidunden@$ip:/home/pidunden/benchmark
  sshtmp pidunden@$ip -f "chmod +x /home/pidunden/benchmark && bash /home/pidunden/benchmark $mtype 3" &
done
