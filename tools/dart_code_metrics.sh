#!/bin/bash
echo "metrics_app running..."
metrics_app=$( make metrics_app )
echo $metrics_app

if grep -iq "Warning" <<< "$metrics_app"; then
    echo "*** METRICS_APP_ERROR contain Warning***: $metrics_app"
    exit 1
fi

if grep -iq "Alarm" <<< "$metrics_app"; then
    echo "*** METRICS_APP_ERROR contain Alarm***: $metrics_app"
    exit 1
fi

echo "*** METRICS_APP_SUCCESS ***"



echo "metrics_data running..."
metrics_data=$( make metrics_data )
echo $metrics_data

if grep -iq "Warning" <<< "$metrics_data"; then
    echo "*** METRICS_DATA_ERROR contain Warning***: $metrics_data"
    exit 1
fi

if grep -iq "Alarm" <<< "$metrics_data"; then
    echo "*** METRICS_DATA_ERROR contain Alarm***: $metrics_data"
    exit 1
fi

echo "*** METRICS_DATA_SUCCESS ***"



echo "metrics_domain running..."
metrics_domain=$( make metrics_domain )
echo $metrics_domain

if grep -iq "Warning" <<< "$metrics_domain"; then
    echo "*** METRICS_DOMAIN_ERROR contain Warning***: $metrics_domain"
    exit 1
fi

if grep -iq "Alarm" <<< "$metrics_domain"; then
    echo "*** METRICS_DOMAIN_ERROR contain Alarm***: $metrics_domain"
    exit 1
fi

echo "*** METRICS_DOMAIN_SUCCESS ***"



echo "metrics_shared running..."
metrics_shared=$( make metrics_shared )
echo $metrics_shared

if grep -iq "Warning" <<< "$metrics_shared"; then
    echo "*** METRICS_SHARED_ERROR contain Warning***: $metrics_shared"
    exit 1
fi

if grep -iq "Alarm" <<< "$metrics_shared"; then
    echo "*** METRICS_SHARED_ERROR contain Alarm***: $metrics_shared"
    exit 1
fi

echo "*** METRICS_SHARED_SUCCESS ***"