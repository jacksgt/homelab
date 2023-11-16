#!/bin/sh
set -e
set -u

if [ "$1" = "powersave" ]; then
	FREQ=1GHz
elif [ "$1" = "performance" ]; then
	FREQ=3.5GHz
else
	echo "Unsupported mode, choose 'powersave' or 'performance'"
	exit 1
fi

CPU_CORES=$(grep processor /proc/cpuinfo | tail -n1 | awk '{print $3}')
for i in $(seq 0 ${CPU_CORES}); do
	cpufreq-set -u ${FREQ} -c $i
done

echo "Adjusted maximum CPU frequency to ${FREQ}"
