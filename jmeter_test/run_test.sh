#!/bin/bash
set -e

# Configuration
JMETER_BIN="/opt/jmeter/bin/jmeter"
JMX_FILE="test_configuration.jmx"

# Hardcoded test parameters
HOST="localhost"
PORT="8000"
ENDPOINT="/heavy"

# Check JMeter installation
if [ ! -x "$JMETER_BIN" ]; then
    echo "JMeter not found at $JMETER_BIN. Please install it first."
    exit 1
fi

# Check if JMX file exists
if [ ! -f "$JMX_FILE" ]; then
    echo "JMX test plan not found: $JMX_FILE"
    exit 1
fi

# Ask for concurrent users
read -p "Enter number of concurrent users: " USERS
RESULTS_FILE="${USERS}_users_results.csv"

# Run JMeter test
echo "Running JMeter test..."
echo "   Host: $HOST"
echo "   Port: $PORT"
echo "   Endpoint: $ENDPOINT"
echo "   Concurrent users: $USERS"
echo

$JMETER_BIN -n -t "$JMX_FILE" \
    -Jhost="$HOST" \
    -Jport="$PORT" \
    -Jendpoint="$ENDPOINT" \
    -Jthreads="$USERS" \
    -l "$RESULTS_FILE"

echo "Test completed. Results saved in: $RESULTS_FILE"