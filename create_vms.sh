#!/bin/bash

for ((z=1; z<9; z++))
do
  gcloud compute instances create instance-$z &
done
wait
