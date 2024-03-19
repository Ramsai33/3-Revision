script_location=$(pwd)

cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

systemctl enable mongod

systemctl start mongod

sed -i -e 's/0.0.0.0/127.0.0.1/gi' /etc/mongod.conf

systemctl restart mongod