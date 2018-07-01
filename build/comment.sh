if [ -s "err" ]
then
  msg=$(head -1 err | sed 's/\"/\\\"/g' )
else
  msg="Build Succesful"
fi
sleep 1
curl -s -H "Authorization: token $TOKEN" -X POST -d "{\"body\": \" $msg \"}" "https://api.github.com/repos/${SEMAPHORE_REPO_SLUG}/issues/${PULL_REQUEST_NUMBER}/comments" > /dev/null
