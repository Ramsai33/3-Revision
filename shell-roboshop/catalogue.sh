script_location=$(pwd)

yum module disable nodejs -y

yum module enable nodejs:18 -y

yum install nodejs -y

useradd roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

cd /app

unzip /tmp/catalogue.zip

cd /app

npm install

cp ${script_location}/files/catalogue.conf /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue

systemctl start catalogue

cp ${script_location} /mongo.conf /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host 172.31.41.30 </app/schema/catalogue.js

