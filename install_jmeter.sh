#!/bin/bash
set -e

JMETER_VERSION="5.6.3"
JMETER_DIR="/opt/jmeter"
JMETER_TGZ="apache-jmeter-$JMETER_VERSION.tgz"
JMETER_URL="https://archive.apache.org/dist/jmeter/binaries/$JMETER_TGZ"

echo "Installing Apache JMeter $JMETER_VERSION (non-GUI mode)..."

# Install Java
sudo apt update -y
sudo apt install -y openjdk-17-jre wget tar

# Download JMeter
wget -q $JMETER_URL -O $JMETER_TGZ

# Extract and install
tar -xzf $JMETER_TGZ
sudo mv "apache-jmeter-$JMETER_VERSION" $JMETER_DIR
rm -f $JMETER_TGZ

# Add to PATH
if ! grep -q "export PATH=\$PATH:$JMETER_DIR/bin" ~/.bashrc; then
    echo "export PATH=\$PATH:$JMETER_DIR/bin" >> ~/.bashrc
fi
source ~/.bashrc

echo "Verifying JMeter installation..."
jmeter -v