#!/bin/bash

firstNR=$(awk '/* xyz*/{ print NR}' ${1}.inp)

head -n $firstNR ${1}.inp > frq_${1}.inp

sed -i 's/Opt/NumFreq/' frq_${1}.inp
sed -i 's/OPT/NumFreq/' frq_${1}.inp
sed -i 's/OptTS/NumFreq/' frq_${1}.inp

tail -n +3 ${1}.files/${1}.xyz >> frq_${1}.inp
echo "*" >> frq_${1}.inp

echo -e "\nYou can find your new input here:\n\n                        frq_${1}.inp\n "
