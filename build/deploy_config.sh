#!/usr/bin/env sh
APPNAME=testapp

mkdir -p /config/${APPNAME}

CURRENT_DEPLOYMENT_FILE=/config/${APPNAME}/current
BLUE_DIRECTORY=/config/${APPNAME}/blue
GREEN_DIRECTORY=/config/${APPNAME}/green
LIVE_SYMLINK_PATH=/config/${APPNAME}/live

if [ -e ${CURRENT_DEPLOYMENT_FILE} ]
then
    CURRENT=`cat ${CURRENT_DEPLOYMENT_FILE}`
    if [ "${CURRENT}" == "green" ]; then
        USE_DEPLOYMENT=${BLUE_DIRECTORY}
        NEW_DEPLOYMENT_COLOR="blue"
    elif [ "${CURRENT}" == "blue" ]; then
        USE_DEPLOYMENT=${GREEN_DIRECTORY}
        NEW_DEPLOYMENT_COLOR="green"
    fi
    echo "Current deployment : ${CURRENT}"
else
    USE_DEPLOYMENT=${BLUE_DIRECTORY}
    NEW_DEPLOYMENT_COLOR="blue"
    echo "No current deployment"
fi

rm -rf ${USE_DEPLOYMENT}
mv /stageConfig ${USE_DEPLOYMENT}

echo "Moving files to ${USE_DEPLOYMENT}"

cd ${USE_DEPLOYMENT}
cd ..

ln -sfn ${NEW_DEPLOYMENT_COLOR} live
echo "Linking ${USE_DEPLOYMENT} to ${LIVE_SYMLINK_PATH}"
echo ${NEW_DEPLOYMENT_COLOR}>${CURRENT_DEPLOYMENT_FILE}