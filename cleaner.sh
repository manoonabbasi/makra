#!/bin/bash
FILE_LIST=$1
#touch cleaner.log
while IFS= read -r FILE_NAME; do
#echo -e "\n\n<----------$FILE_NAME---------->\n\n" >> cleaner.log
while IFS= read -r e_data; do
user_name=$(echo $e_data | cut -d@ -f1)
domain=$(echo $e_data | cut -d@ -f2)

if grep -q $user_name "rbe.names"; then
echo -e "User name matched. Email skipped! USER: $user_name, Email (SWITCH(s)): $e_data\n"
else
echo -e "$e_data" >> $FILE_NAME.tmp
fi
done < "$FILE_NAME"

cat $FILE_NAME.tmp | cut -d@ -f2 | sort | uniq > core.tmp

while IFS= read -r su_data; do

g_data=$(cat $FILE_NAME.tmp | grep "$su_data")

echo -e "\"$su_data\"" >> $FILE_NAME.VALID
echo -e "$g_data\n" >> $FILE_NAME.VALID

done < "core.tmp"

fname=$(echo -e $FILE_NAME | cut -d. -f1)
rm $FILE_NAME.tmp
rm core.tmp
mv $FILE_NAME  $FILE_NAME.temp
mv $FILE_NAME.VALID  $fname.VALID.csv
mv $fname.VALID.csv $FILE_NAME
rm $FILE_NAME.temp
sed 's/\"//g' $FILE_NAME > $FILE_NAME.temp
rm $FILE_NAME
mv $FILE_NAME.temp $FILE_NAME
done < "$FILE_LIST"
