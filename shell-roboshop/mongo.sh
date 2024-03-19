source common.sh

print_head "Copying Mongo file"
cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo
status

print_head "Install Mongodb"
yum install mongodb-org -y
status

print_head "Enable Mongo"
systemctl enable mongod
status

print_head"Start Mongo"
systemctl start mongod
status

print_head "Change Port"
sed -i -e 's/127.0.0.1/0.0.0.0/gi' /etc/mongod.conf
status

print_head "Restart"
systemctl restart mongod
status