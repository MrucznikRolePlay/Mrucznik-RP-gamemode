#!/bin/bash

indexes=('admin' 'adminduty' 'connect' 'damage' 'error' 'money' 'mysql' 'nick' 'pay' 'premium' 'punishment' 'sejf' 'server' 'warning')
months=('2019.08' '2019.09' '2019.10' '2019.11' '2019.12' '2020.01')
for month in "${months[@]}"; do
  for index in "${indexes[@]}"; do
    indexName="logstash-samp-$index-$month"
    echo "Reindexing $indexName ..."
    curl -HContent-Type:application/json -u elastic:pass -XPOST localhost:9200/_reindex?pretty -d'{
      "source": {
        "index": "'$indexName'"
      },
      "dest": {
        "index": "'$indexName'-reindexed"
      }
    }'
    echo "Done"
  done
done

read