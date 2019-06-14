#!/bin/bash

# Print the usage message
function printHelp() {
  echo "Usage: "
  echo "  fabric-client <command>"
  echo "    <command> - one of 'start', 'stop', 'restart', 'up', 'down', 'clear'" or "logs"
  echo "      - 'start' - start the node with docker-compose start"
  echo "      - 'stop' - stop the node with docker-compose stop"
  echo "      - 'restart' - restart the node"
  echo "      - 'up' - start the node with docker-compose up -d"
  echo "      - 'down' - stop the node with docker-compose down"
  echo "      - 'clear' - clear the node's resource"
  echo "      - 'logs' - print the container logs"
}


if [ "$1" == "start" ]; then ## Start
  docker-compose -f docker-compose.yaml start
elif [ "$1" == "stop" ]; then ## Stop 
  docker-compose -f docker-compose.yaml stop
elif [ "$1" == "restart" ]; then ## Restart
  docker-compose -f docker-compose.yaml restart
elif [ "$1" == "up" ]; then ## up
  docker-compose -f docker-compose.yaml up -d
elif [ "$1" == "down" ]; then ## down
  docker-compose -f docker-compose.yaml down
elif [ "$1" == "clear" ]; then ## Clear
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq) -f
  docker volume prune
elif [ "$1" == "clear" ]; then ## logs
  docker-compose -f docker-compose.yaml logs -f
else
  printHelp
  exit 1
fi
