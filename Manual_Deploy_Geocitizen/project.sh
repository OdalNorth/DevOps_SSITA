#!/bin/bash

sudo rm -rf /opt/tomcat/latest/webapps/citizen.war

sleep 10

git clone "https://github.com/mentorchita/Geocit134.git"

#initialization credential variable

mail=$1
mail_password=$2

server_app="192.168.43.121"
server_db="192.168.43.61"
name_db="geocitizen"

echo "Fix dependencies"


# Fix pom.xml for mvn install

sed -i "s/>servlet-api/>javax.servlet-api/g" Geocit134/pom.xml
sed -i -E "s/(http:\/\/repo.spring)/https:\/\/repo.spring/g" Geocit134/pom.xml
sed -i "/<distributionManagement>/,/<\/distributionManagement>/d" Geocit134/pom.xml

# Fix application.properties for url and db ip

sed -i -E "s/ss_demo_1/$name_db/g" Geocit134/src/main/resources/application.properties
sed -i "s/http:\/\/localhost/http:\/\/$server_app/g" Geocit134/src/main/resources/application.properties
sed -i -E "s/postgresql:\/\/localhost/postgresql:\/\/$server_db/g" Geocit134/src/main/resources/application.properties
sed -i "s/postgresql:\/\/35.204.28.238/postgresql:\/\/$server_db/g" Geocit134/src/main/resources/application.properties
sed -i "s/ssgeocitizen@gmail.com/$mail/g" Geocit134/src/main/resources/application.properties
sed -i "s/=softserve/=$mail_password/g" Geocit134/src/main/resources/application.properties

# Fix front-end

sed -i "s/\/src\/assets/\.\/static/g" Geocit134/src/main/webapp/index.html

sed -i "s/localhost/$server_app/g" Geocit134/src/main/java/com/softserveinc/geocitizen/configuration/MongoConfig.java   
sed -i "s/localhost/$server_app/g" Geocit134/src/main/webapp/static/js/app.6313e3379203ca68a255.js
sed -i "s/localhost/$server_app/g" Geocit134/src/main/webapp/static/js/app.6313e3379203ca68a255.js.map
sed -i "s/localhost/$server_app/g" Geocit134/src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js
sed -i "s/localhost/$server_app/g" Geocit134/src/main/webapp/static/js/vendor.9ad8d2b4b9b02bdd427f.js.map

echo "Building project"

(ls)

(cd Geocit134; eval mvn install)

echo "Deploying project"

sudo cp Geocit134/target/citizen.war /opt/tomcat/latest/webapps

sleep 20