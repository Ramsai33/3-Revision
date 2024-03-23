source common.sh

head "Install Nginx"
yum install nginx -y  -y &>>${log}
status

head "Enable nginx"
systemctl enable nginx &>>${log}
status

head "start Nginx"
systemctl start nginx &>>${log}
status

head "Delete Default content"
rm -rf /usr/share/nginx/html/* &>>${log}
status

head "Download Frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
status

head "change directory"
cd /usr/share/nginx/html &>>${log}
status

head "Unzip"
unzip /tmp/frontend.zip &>>${log}
status

head "Copying configuration"
cp ${script_location}/files/frontend.conf /etc/nginx/default.d/roboshop.conf &>>${log}
status

head "Restart Nginx"
systemctl restart nginx &>>${log}
status