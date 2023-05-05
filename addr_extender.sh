#!/bin/bash
E_FILE=$1
RD_FILE=1
DFNAME=""
while [ $RD_FILE -le 36 ]
do
cntr=$(36-$RD_FILE)
echo -n "Pending CATs: $cntr"
while read -r EFNAME; do
DFNAME=$EFNAME
while read -r EMAILS; do
#echo -e "$EMAILS exist\n"
var=$EMAILS
if [ -n "$var" ]
then
if [[ $var != *"@"* ]]; then
  echo "Skipping" > /dev/null 2>&1
else
#echo "$var" >> EMA
if grep -q "$var" "$RD_FILE.csv"; then

adr_data=$(cat $RD_FILE.csv | grep $var | uniq)
addr=$(echo -e $adr_data | cut -d';' -f1 | uniq)

echo -e "$var","$addr" >> ema

else
echo -e "$var","INDIVIDUAL" >> ema
addr="INDIVIDUAL"
fi
fi
else
echo -e "DNE" > /dev/null 2>&1
fi
faddr=$(echo -e $addr | sed 's/"//g')
echo -e $faddr >> subject.addr

done < "$EFNAME"
#--------------------

#SECTION-2
cat ema | sed 's/"//g' | uniq > ema.tmp
cat ema.tmp | rev | cut -c2- | rev | uniq > ema.ttmp
rm ema
rm ema.tmp
mv ema.ttmp ema

cat subject.addr | sort | uniq > subject.addrs
rm subject.addr
cat subject.addrs | rev | cut -c2- | rev | uniq > a.tmp
rm subject.addrs
mv a.tmp subject.addrs

tail -n +2 subject.addrs > subject.adr
rm subject.addrs
mv subject.adr subject.addrs


while read -r ecs; do
cat ema | grep "$ecs" | uniq > a.data
cat a.data | cut -d',' -f1 | uniq > b.data
cecs=${ecs^^}
echo -e $cecs >> final.csv
cat b.data | uniq -u >> final.csv
echo -e "\n" >> final.csv
done < "subject.addrs"
rm $DFNAME
mv final.csv $DFNAME
rm a.data
rm b.data
rm subject.addrs
rm ema
((RD_FILE=RD_FILE+1))
done < "$E_FILE"
done
