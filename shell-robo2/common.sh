script_location=$(pwd)
log=/tmp/roboshop.log

head() {

  echo -e "\e[1m $1\e[0m"

}

status() {

  if [ $? -eq 0 ]; then
    echo -e '\e[33m Success \e[0m'
  else
    echo -e '\e[32m Failed \e[0m'
  exit
  fi

}

AppPreReq() {

  head "Add roboshop"
  id roboshop &>>${log}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${log}
  fi

  rm -rf /app/*

  head "Add Directory"
  mkdir -p /app &>>${log}
  status


  head "Download APP content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  status

  cd /app

  head "Extract App Content"
  unzip /tmp/${component}.zip &>>${log}
  status

  cd /app &>>${log}

}

Demonload() {

  head "Copy Conf"
  cp ${script_location}/files/${component}.conf /etc/systemd/system/${component}.service &>>${log}
  status

  head "Deman reload"
  systemctl daemon-reload &>>${log}
  status

  head "Enable service"
  systemctl enable ${component} &>>${log}
  status

  head "Start Service"
  systemctl start ${component} &>>${log}
  status

}

schema_load() {

if [ "$schema" = "true" ]; then
  if [ "$schema_type" = "mongodb" ]; then
      head "Install Mongo"
      yum install mongodb-org-shell -y &>>${log}
      status

      head "Schema into mongo server"
      mongo --host 172.31.38.96 </app/schema/${component}.js &>>${log}
      status
  fi
  if [ "$schema_type" = "mysql" ]; then
    echo "Hai Friend"
  fi
fi

}

Nodejs() {

  head "Disable nodejs"
  yum module disable nodejs -y &>>${log}
  status

  head "enable nodejs"
  yum module enable nodejs:18 -y &>>${log}
  status

  head "Install Nodejs"
  yum install nodejs -y &>>${log}
  status

  AppPreReq

  head "NPM Install"
  npm install &>>${log}
  status

  Demonload

   head "Copy Mongo repo"
    cp ${script_location}/files/mongo.conf /etc/yum.repos.d/mongo.repo &>>${log}
    status

  schema_load

}