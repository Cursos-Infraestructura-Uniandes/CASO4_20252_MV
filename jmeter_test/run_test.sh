#!/bin/bash
set -e

PORT="8000"
HOST="localhost"
RESULTS_DIR="./results"
JMETER_BIN="/opt/jmeter/bin/jmeter"
JMX_FILE="test_configuration.jmx"

# --- START WEB SERVER ---
if ! lsof -i :$PORT -t > /dev/null 2>&1; then
    mkdir -p "$RESULTS_DIR"
    (cd "$RESULTS_DIR" && python3 -m http.server "$PORT" > /dev/null 2>&1 &)
fi

# --- REQUEST DATA ---
read -p "Número de usuarios concurrentes: " USERS
read -p "ID del paquete a rastrear: " PACKAGE_ID

# --- VERIFICATIONS ---
[ ! -x "$JMETER_BIN" ] && echo "JMeter not found at $JMETER_BIN" && exit 1
[ ! -f "$JMX_FILE" ] && echo "JMX File not found: $JMX_FILE" && exit 1

# --- EXECUTE TEST ---
RESULTS_FILE="$RESULTS_DIR/${USERS}_users.csv"
rm -f "$RESULTS_FILE"

echo "
Ejecutando test JMeter...
   Host: $HOST
   Port: $PORT
   Endpoint: /packages/${PACKAGE_ID}/track
   Usuarios: $USERS
"

$JMETER_BIN -n -t "$JMX_FILE" \
    -Jhost="$HOST" \
    -Jport="$PORT" \
    -Jendpoint="/packages/${PACKAGE_ID}/track" \
    -Jthreads="$USERS" \
    -l "$RESULTS_FILE"

echo "
================================================================
Test completado
Resultados: $RESULTS_FILE
Ver en navegador para descargar archivo: http://$HOST:$PORT/
================================================================"