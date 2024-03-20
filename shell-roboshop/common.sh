script_location=$(pwd)
log=/tmp/roboshop.log

print_head() {
  echo -e "\e[1m $1 \e[0m"
}

status() {
if [ $? -eq 0 ]; then
  echo -e '\e[32m SUCCESS \e[0m'
else
  echo -e '\e[31m FAILURE \e[0m'
exit
fi
}

AppPre_req() {
  print_head "User add"
  id roboshop &>>${log}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${log}
  fi
  status

  print_head "creating app"
  mkdir -p /app &>>${log}
  status

  print_head "Download Catalogue content"
  curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
  status

  print_head "remove app content"
  rm -rf /app/*
  status

  cd /app &>>${log}

  print_head "UnZip"
  unzip /tmp/catalogue.zip &>>${log}
  status
}

systemd() {

  print_head "Demon reload"
  systemctl daemon-reload &>>${log}
  status

  print_head "Enable service"
  systemctl enable catalogue &>>${log}
  status

  print_head "start service"
  systemctl start catalogue &>>${log}
  status

}

schema_load() {

  print_head "Copy Mongo repo"
  cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
  status

  print_head "Install Mongo"
  yum install mongodb-org-shell -y &>>${log}
  status

  print_head "Load Schema"
  mongo --host 172.31.40.164 </app/schema/catalogue.js &>>${log}
  status

}