#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nWelcome to My Salon, how can I help you?"
  echo -e "\n1) Cut hair\n2) Wash hair\n3) Dye hair\n4) Exit\n"
  read SERVICE_ID_SELECTED
  case $SERVICE_ID_SELECTED in
    1) CUT_MENU;;
    2) WASH_MENU;;
    3) DYE_MENU;;
    4) EXIT;;
    *) MAIN_MENU "Please enter a valid option.";;
  esac
}

CUT_MENU(){
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  echo -e "\nWhat time would you like your cut, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME

  # insert cut appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  # get appointment info
  APPOINTMENT_INFO=$($PSQL "SELECT time FROM appointments WHERE customer_id = $CUSTOMER_ID" AND service_id = $SERVICE_ID_SELECTED)

  APPOINTMENT_INFO_FORMATTED=$(echo $APPOINTMENT_INFO | sed 's/ |/"/')

  echo -e "I have put you down for a cut at $APPOINTMENT_INFO_FORMATTED, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}

WASH_MENU(){
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  echo -e "\nWhat time would you like your wash, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME

  # insert wash appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  # get appointment info
  APPOINTMENT_INFO=$($PSQL "SELECT time FROM appointments WHERE customer_id = $CUSTOMER_ID" AND service_id = $SERVICE_ID_SELECTED)

  APPOINTMENT_INFO_FORMATTED=$(echo $APPOINTMENT_INFO | sed 's/ |/"/')

  echo -e "I have put you down for a wash at $APPOINTMENT_INFO_FORMATTED, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."

}

DYE_MENU(){
  # get customer info
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    # get new customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  echo -e "\nWhat time would you like your dye, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME

  # insert dye appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  # get appointment info
  APPOINTMENT_INFO=$($PSQL "SELECT time FROM appointments WHERE customer_id = $CUSTOMER_ID" AND service_id = $SERVICE_ID_SELECTED)

  APPOINTMENT_INFO_FORMATTED=$(echo $APPOINTMENT_INFO | sed 's/ |/"/')

  echo -e "I have put you down for a dye at $APPOINTMENT_INFO_FORMATTED, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}

EXIT(){
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU
