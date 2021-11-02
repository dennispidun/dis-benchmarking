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

echo "time;eps;min_latency;max_latency;avg_latency;95th_percentile" > results.csv

for ip in $ips
do
  echo "Collecting: $ip"
  scptmp pidunden@$ip:/home/pidunden/results.csv benchmark_$ip.csv
  cat benchmark_$ip.csv >> results.csv
done

rm -rf benchmark_*.csv
