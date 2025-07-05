#!/bin/bash

# Minecraft Server Start Script
# This script helps you start your Minecraft server, allocate memory,
# and automatically restart it if it crashes.

# --- Configuration ---
#
# Path to your Java executable.
# If 'java' is in your PATH, you can just use 'java'.
# Otherwise, provide the full path, e.g., /usr/lib/jvm/java-17-openjdk/bin/java
java_executable="java"

# Name and path of your Minecraft server JAR file.
# Make sure this matches the exact filename, e.g., server.jar, paper.jar, fabric-server-launch.jar
server_path="/REPLACE/THE/REAL/PATH"
jar_name="server.jar"

# Memory allocation for the server.
# ini_memory: Initial Java heap size (e.g., 1 for 1 Gigabyte)
# max_memory: Maximum Java heap size (e.g., 4 for 4 Gigabytes)
# Adjust these values based on your server's needs and available RAM.
# A good starting point for a small server is 1G and 2G.
# For larger servers with many players/plugins, you might need 4G, 6G, or more.
declare -i ini_memory=$(( 1 * 1024))
declare -i max_memory=$(( 1 * 1024))

allocation="-Xmx${max_memory}M -Xms${ini_memory}M"

# A flag to control if the server should automatically restart on crash.
# Set to 'true' to enable automatic restarts, 'false' to disable.
auto_restart=true



# --- Script Logic ---
echo "Changing directory to \"$server_path\"..."
cd $server_path || {
  echo "ERROR: Couldn't change directory to \"$server_path\", double check please.";
  exit 1;
}

echo "Starting Minecraft server..."
echo "Using Java: $java_executable"
echo "Server JAR: $jar_name"
echo "Memory Allocation: ini: ${ini_memory}MB max: ${max_memory}MB"

# Loop to keep the server running and restart it if it crashes
while true; do
    echo "-----------------------------------------------------"
    echo "Launching server at $(date)"
    echo "Command: ${java_executable} ${allocation} -jar $jar_name nogui"
    echo "-----------------------------------------------------"

    "${java_executable}" ${allocation} -jar "$jar_name" nogui

    # Check the exit status of the last command
    exit_status=$?

    if [ ${exit_status} -eq 0 ]; then
        echo "Server stopped gracefully."
        break # Exit loop if server stopped without error (e.g., via 'stop' command)
    else
        echo "Server crashed with exit code ${exit_status}!"
        if [ "${auto_restart}" = "true" ]; then
            echo "Restarting server in 5 seconds..."
            sleep 5
        else
            echo "Automatic restart is disabled. Server will not restart."
            break # Exit loop if auto-restart is disabled and server crashed
        fi
    fi
done

echo "Minecraft server script finished."
