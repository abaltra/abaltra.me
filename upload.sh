#!/bin/bash

aws s3 cp . s3://abaltra.me --recursive --exclude 'upload.sh' --exclude "*.terraform*" --exclude "*tfstate*" --exclude "*.git*" --exclude "*.DS_Store*"--profile abaltra
