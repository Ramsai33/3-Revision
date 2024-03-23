source common.sh

head "Copying Repo"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
status

head "Install mongodb"
yum install mongodb-org -y &>>${log}
status

head "Enable Mongo"
systemctl enable mongod &>>${log}
status

head "Start Mongo"
systemctl start mongod &>>${log}
status

head "Changing Port"
sed -i -e 's/127.0.0.1/0.0.0.0/gi' /etc/mongod.conf &>>${log}
status

head "Restart Mongo"
systemctl restart mongod &>>${log}
status