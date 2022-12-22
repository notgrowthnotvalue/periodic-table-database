#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


# If the argument is not provided
if [[ ! $1 ]]
then 
  echo -e "Please provide an element as an argument."
# if argument is provided and is a number
elif [[ $1 =~ [[1-9]|10] ]]
then 
  NUMBER=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1")
  echo $NUMBER | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME
  do 
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM properties full join types using (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
    # using sed to remove whitespace
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed -r 's/\s+/ /g'
  done
# if argument is provided and is a symbol
elif [[ $1 =~ ^([A-Z]|[A-Z][a-z])$ ]]
then
  SYMBOL=$($PSQL "SELECT * FROM elements WHERE symbol='$1'")
  echo $SYMBOL | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME
  do 
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM properties full join types using (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
    # using sed to remove whitespace
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed -r 's/\s+/ /g'
  done
#if argument is provided and is a name
elif [[ $1 =~ ^[A-Z][a-z]*$ ]]
then
  NAME=$($PSQL "SELECT * FROM elements WHERE name='$1'")
  echo $NAME | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME
  do 
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM properties full join types using (type_id) WHERE atomic_number=$ATOMIC_NUMBER")
    # using sed to remove whitespace
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius." | sed -r 's/\s+/ /g'
  done
# if argument is provided but does not exist
else 
  echo "I could not find that element in the database."
fi