
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

