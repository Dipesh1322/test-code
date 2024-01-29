sudo apt-get update && sudo apt-get -y install awscli
if [ "$5" = "yes" ] && [ "$6" = "no" ]
then
	echo "$5 is yes and $6 is no!"
	aws configure set aws_access_key_id $1
	aws configure set aws_secret_access_key $2
	aws configure set default.region $3
	cd ./code/lib
	zip -r corelib.zip ./corelib 
	aws s3 cp corelib.zip s3://$4/lib/
	cd ../..
	aws s3 sync ./code/ s3://$4/ --exclude 'lib/*' --exclude 'deploy.sh'
elif [ $5 == "no" ] && [ $6 == "yes" ]
then
	echo "$5 is no and $6 is yes!"
elif [ $5 == "yes" ] && [ $6 == "yes" ]
then
	echo "Both $5 and $6 are yes!"
fi