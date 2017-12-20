#!/bin/bash
printf "\nEnvironment = %s\n\n" "$1"

failure_occurred=false
declare -a urllist=("https://$1.mysite.com/"
"https://$1.mysite.com/someotherroute")

# Add environment specific urls to check here if desired
case $1 in
    "dev"| "test") 
    urllist+=("https://$1.mysite.com/a/lower/env/only/route"
      "https://$1.mysite.com/another/lower/env/route")
    ;;
    "preprod") 
    urllist+=("https://$1.mysite.com/a/higher/env/route")
    ;;
    *) 
    echo "ERROR - invalid environment, must be in dev, test, preprod"
    exit 1
    ;;
esac

for url in "${urllist[@]}"
do
    code=`curl -sL -w "%{http_code}\\n" "$url" -o /dev/null`
    if [ "x$code" = "x200" ]
    then
         echo "$code - $url"
    else
         echo "ERROR $code - $url"
         failure_occurred=true
    fi
done

if [ "$failure_occurred" = true ] 
then 
	printf "\nERROR - one or more endpoints returned a failure\n\n"
    exit 1
else
	printf "\nSUCCESS - all endpoints returned a 200\n\n"
fi
