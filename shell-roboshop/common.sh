script_location=$(pwd)
log=/tmp/roboshop



status() {
if [ $? -eq 0 ]; then
  echo -e '\e[35m SUCCESS \e[0m'
else
  echo -e '\e[32m FAILURE \e[0m'
exit
fi
}