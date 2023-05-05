#!/bin/bash
LIST=$1
while IFS= read -r FILE_NAME; do
awk '{print tolower($0)}' < $FILE_NAME > $FILE_NAME.lower
rm $FILE_NAME
mv $FILE_NAME.lower $FILE_NAME
wait
#duplicate lines remover
sort $FILE_NAME | uniq -u > $FILE_NAME.uniq
rm $FILE_NAME
mv $FILE_NAME.uniq $FILE_NAME
done < "$LIST"
