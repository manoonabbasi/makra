#!/bin/bash
FILE_LIST=$1
i=1
touch operation.log
while IFS= read -r FILE_NAME; do
echo -e "\n\n#$i  <---------- FILE: $FILE_NAME ---------->\n\n"
while IFS= read -r e_mails; do

a="INVALID"
b="ERROR"
c="RCRD"
d="invalid"
e="error"
f="rcrd"

if grep -q "$a" <<< "$e_mails"; then
echo -e "$e_mails: $a\n"
elif grep -q "$b" <<< "$e_mails"; then
echo -e "$e_mails: $b\n"
elif grep -q "$c" <<< "$e_mails"; then
echo -e "$e_mails: $c\n"
elif grep -q "$d" <<< "$e_mails"; then
echo -e "$e_mails: $d\n"
elif grep -q "$e" <<< "$e_mails"; then
echo -e "$e_mails: $e\n"
elif grep -q "$f" <<< "$e_mails"; then
echo -e "$e_mails: $f\n"
else
echo -e "$e_mails: Approved\n"
fdata=$(echo $e_mails | cut -d, -f1)
echo -e "$fdata" >> $FILE_NAME.tmp
fi

done < "$FILE_NAME"
FNAME=$(echo -e $FILE_NAME | cut -d. -f1)
rm $FILE_NAME
mv $FILE_NAME.tmp $FNAME.csv

((i=i+1))
done < "$FILE_LIST"
