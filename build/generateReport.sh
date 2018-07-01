#!/bin/bash

username=$(curl -s -H "Authorization: token ${TOKEN}" -X GET "https://api.github.com/repos/${SEMAPHORE_REPO_SLUG}/pulls/${PULL_REQUEST_NUMBER}" | jq -r '.user.login')

git config --global user.email "LinkedDataCommenter@yandex.com"
git config --global user.name "LinkedDataCommenter"

git clone https://github.com/WebServicesAndLinkedData/Assignment1.git
cd Assignment1
DATE=`date +%Y-%m-%d`
sed -i '/Assignment 2,*/d' $username.csv

if [ -s "err" ]; then
   echo "[CI SKIP] Assignment 2, Submitted with errors, " $DATE >> $username.csv
else
   echo "[CI SKIP] Assignment 2, Submitted succesfully, " $DATE >> $username.csv
fi

git add $username.csv
git commit -m "$username report updated"
git push https://LinkedDataCommenter:$TOKEN@github.com/WebServicesAndLinkedData/Assignment1.git &> /dev/null
