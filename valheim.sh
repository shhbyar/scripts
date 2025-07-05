#!/bin/bash
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# This scripts runs the "Valheim Dedicated Server" with desired options.

# ------- Configuration ---------
#
# Path to server file
server_path="/home/ubuntu/.local/share/Steam/steamapps/common/Valheim dedicated server"
exec_path="valheim_server.x86_64"

# Port number.
# Default 2456
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
# We suggest you don't change this port
port="2456"

server_name="viking"

# Default would be "Dedicated"
world_name="NewOne"

# The password witch players will use to connect to this server.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
password="maybe"


# ------- Logic ---------

cd "${server_path}" || {
  echo "ERROR: Couldn't change directory to \"$server_path\", double check please.";
  exit 1;
}

echo "Starting Valheim server..."

./"${exec_path}" -name "${server_name}" -port ${port} -world "${world_name}" -password "${password}" -public 1


export LD_LIBRARY_PATH=$templdpath