source common.sh

print_head "Install NGINX"
yum install nginx -y &>>${log}
status

print_head "Enable Nginx"
systemctl enable nginx &>>${log}
status

print_head "Start Nginx"
systemctl start nginx &>>${log}
status

print_head "Remove Default content"
rm -rf /usr/share/nginx/html/* &>>${log}
status

print_head "Download frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
status

print_head "unzip"
cd /usr/share/nginx/html &>>${log}
unzip /tmp/frontend.zip &>>${log}
status


print_head "File copying"
cp ${script_location}/files/frontend.conf /etc/nginx/default.d/roboshop.conf &>>${log}
status

print_head "Restart Nginx"
systemctl restart nginx &>>${log}
status