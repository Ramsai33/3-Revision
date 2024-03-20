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

  print_head "Download ${component} content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  status

  print_head "remove app content"
  rm -rf /app/*
  status

  cd /app &>>${log}

  print_head "UnZip"
  unzip /tmp/${component}.zip &>>${log}
  status
}

systemd() {

  print_head "Demon reload"
  systemctl daemon-reload &>>${log}
  status

  print_head "Enable service"
  systemctl enable ${component} &>>${log}
  status

  print_head "start service"
  systemctl start ${component} &>>${log}
  status

}

schema_load() {
  if [ $schema_load == "true" ]; then

  print_head "Copy Mongo repo"
  cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
  status

  print_head "Install Mongo"
  yum install mongodb-org-shell -y &>>${log}
  status

  print_head "Load Schema"
  mongo --host 172.31.40.164 </app/schema/${component}.js &>>${log}
  status
exit
fi
}

nodejs() {

  print_head "Disable Repo"
  yum module disable nodejs -y &>>${log}
  status

  print_head "Enable Nodejs"
  yum module enable nodejs:18 -y &>>${log}
  status

  print_head "InstallNodejs"
  yum install nodejs -y &>>${log}
  status

  AppPre_req

  print_head "Chnge dir"
  cd /app &>>${log}
  status
  print_head "NPM Install"
  npm install &>>${log}
  status

  print_head "Copy File"
  cp ${script_location}/files/${component}.conf /etc/systemd/system/${component}.service &>>${log}
  status

  systemd

  schema_load

}