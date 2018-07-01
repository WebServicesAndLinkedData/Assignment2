if [ -s "err" ]
then
  msg=$(sed ':a;N;$!ba;s/\n/<br\/>/g' err | sed 's/\"/\\\"/g' )
else
  msg="Build Succesful"
fi
sleep 1
curl -H "Authorization: token $TOKEN" -X POST -d "{\"body\": \" $msg \"}" "https://api.github.com/repos/${SEMAPHORE_REPO_SLUG}/issues/${PULL_REQUEST_NUMBER}/comments" > /dev/null
