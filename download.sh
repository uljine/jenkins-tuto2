#!/bin/bash
set -e

# Define URLs and destination paths
JENKINS_WAR_URL="https://get.jenkins.io/war-stable/latest/jenkins.war"
JENKINS_WAR_DEST="app/jenkins/jenkins.war"
PLUGINS_DIR="app/jenkins/plugins"

# Create necessary directories
mkdir -p $(dirname "$JENKINS_WAR_DEST")
mkdir -p "$PLUGINS_DIR"

# Download Jenkins WAR file
echo "Downloading Jenkins WAR file..."
curl -fLo "$JENKINS_WAR_DEST" "$JENKINS_WAR_URL"

# Download plugins
echo "Downloading plugins..."
while IFS= read -r plugin; do
  echo "Downloading plugin: $plugin"
  curl -fLo "$PLUGINS_DIR/${plugin}.hpi" "https://updates.jenkins.io/latest/${plugin}.hpi"
done < plugins.txt

echo "Download completed."
