#!/usr/bin/env bash

# ex) target text abc : 123, please##

result="$(
grep 'target text' target.log* | 
sed "s/^.*target text, //" |
sed "s/, please.*$//" |
sed 's/##//g' |
sed 's/abc :/type/g')"

api="http://localhost:8080/api"

echo $result

str=$api
count=0


for item in $result
do

    count=$(( ${count}+1 ))

    str=$str'/'$item

    rem=`expr $count % 2`

        if [ $rem -eq 0 ]
        then
                echo $str
                curl -X GET $str
                str=$api
        fi

done
