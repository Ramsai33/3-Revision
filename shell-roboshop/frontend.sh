import common.sh

echo -e '\e[33m Install nginx\e[0m'
yum install nginx -y &>>${log}
status

echo -e '\e[33m enable nginx\e[0m'
systemctl enable nginx &&>>${log}
status

echo -e '\e[33m Start nginx\e[0m'
systemctl start nginx &&>>${log}
status

echo -e '\e[33m remove default content\e[0m'
rm -rf /usr/share/nginx/html/* &&>>${log}
status

echo -e '\e[33m downloadapp content\e[0m'
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &&>>${log}
status

echo -e '\e[33m unzip+\e[0m'
cd /usr/share/nginx/html &&>>${log}
unzip /tmp/frontend.zip &&>>${log}
status

echo -e '\e[33m Install nginx\e[0m'

status

echo -e '\e[33m Install nginx\e[0m'
cp ${script_location}/files/frontend.conf /etc/nginx/default.d/roboshop.conf &&>>${log}
status

echo -e '\e[33m restart nginx\e[0m'
systemctl restart nginx &&>>${log}
status