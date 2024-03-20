script_location=$(pwd)
set -e

yum module disable nodejs -y

yum module enable nodejs:18 -y

yum install nodejs -y


id roboshop
if [ $? -ne 0 ]; then
  useradd roboshop
fi

mkdir -p /app


curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

rm -rf /app/*

cd /app

unzip /tmp/catalogue.zip

cd /app

npm install

cp ${script_location}/files/catalogue.conf /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue

systemctl start catalogue

cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y

mongo --host 172.31.40.164 </app/schema/catalogue.js

