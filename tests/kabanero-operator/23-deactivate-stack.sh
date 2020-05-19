#!/bin/bash

# Delete a stack and ensure the operator reconciler does not reactivate it

set -Eeox pipefail

namespace=kabanero

ORIGYAML=$(oc get -n ${namespace} stack quarkus --export -o=json)

oc -n ${namespace} patch stack quarkus --type='json' -p='[{"op": "replace", "path": "/spec/versions/0/desiredState", "value":"inactive"}]'

echo "Waiting for quarkus stack to deactivate"
LOOP_COUNT=0
until [ "$STATUS" == "inactive" ] 
do
  STATUS=$(oc -n ${namespace} get stack quarkus -o jsonpath='{.status.versions[0].status}')
  sleep 5
  LOOP_COUNT=`expr $LOOP_COUNT + 1`
  if [ $LOOP_COUNT -gt 120 ] ; then
    echo "Timed out waiting for quarkus stack to deactivate"
  exit 1
 fi
done

# Reset 
echo $ORIGYAML | oc apply -f -
