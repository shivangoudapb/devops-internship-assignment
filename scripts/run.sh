#!/bin/bash

export III_DISABLE_VM=true

cd quickstart/workers/caller-worker
npm install

cd ../inference-worker
pip3 install iii-sdk watchfiles

cd ../../

iii &
sleep 5

cd workers/caller-worker
npm run dev &
sleep 5

cd ../inference-worker
python3 inference_worker.py