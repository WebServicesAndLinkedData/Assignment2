#!/bin/bash

#Name: testAssignment2.sh
#Description: Validates that the assignment files exist and are correct
#Parameters: None
#Output: Descriptions of errors found
#Exit Value: Number of errors found, 0 if the files were correct

#Check username of pull-request
errors=0
missingrdf=false
missingttl=false
sleep 2
username=$(curl -s -H "Authorization: token $TOKEN" -X GET "https://api.github.com/repos/${SEMAPHORE_REPO_SLUG}/pulls/${PULL_REQUEST_NUMBER}" | jq -r '.user.login')
#Check files exist
#	{username}.rdf
if [ ! -f "$username.rdf" ]
then
    echo "RDF file missing. Make sure it has the correct format" $username.rdf >&2
	missingrdf=true
	errors=$((errors+1))
fi

#	{username}.ttl
if [ ! -f "$username.ttl" ]
then
    echo "TTL file missing. Make sure it has the correct format" $username.ttl >&2
	missingttl=true
	errors=$((errors+1))
fi
#	{username}.png
if [ ! -f "$username.png" ]
then
    echo "PNG file missing. Make sure it has the correct format" $username.png >&2
	errors=$((errors+1))
fi

#Validate rdf and ttl
if [ "$missingrdf" != true ] && [ "$missingttl" != true ]
then
	java -cp ./test/jena-1.jar Test $username >&2
	if [[ $? -ne 0 ]]
	then
		errors=$((errors+1))
	fi
fi

#Add name to report file if it doesnt exist with field of correct or incorrect build


exit $errors
