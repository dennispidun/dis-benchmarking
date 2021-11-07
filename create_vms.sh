#!/bin/bash

# f1-micro        europe-central2-a  1     0.60
# n2-highcpu-2    europe-central2-a  2     2.00
# n1-highcpu-2    europe-central2-a  2     1.80
# n2-highcpu-4    europe-central2-a  4     4.00
# n2-standard-2   europe-central2-a  2     8.00
# e2-standard-2   europe-central2-a  2     8.00
# e2-small        europe-central2-a  2     2.00
# e2-highcpu-2    europe-central2-a  2     2.00

types=("f1-micro" "n1-highcpu-2" "n2-highcpu-2" "n2-highcpu-4" "n2-standard-2" "e2-standard-2" "e2-small" "e2-highcpu-2")
#
for type in "${types[@]}"

do
  gcloud compute instances create instance-$type --machine-type=$type --image-project=ubuntu-os-cloud --image-family=ubuntu-1804-lts --boot-disk-size=105G --async &
done
wait
