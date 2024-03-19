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