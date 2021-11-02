#!/bin/bash
instances=$(gcloud compute instances list | awk 'NR!=1 {print $1}')
gcloud compute instances delete $instances
