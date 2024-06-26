#!/bin/bash

echo -n -e "${C_GREEN}"

# Chcking if ansible folder exists, if not then including requirements installer
if [[ ! -d "/srv/ansible" ]]; then

  echo -e "Running first-run requirements installer..."
  # shellcheck disable=SC1091
  source scripts/general/install-requirements.sh EXTRA

fi

# Installing or updating yarn npm packages
# Using /dev/null because the --silent flag is not working for some reason anymore
(cd /srv/ && yarn install > /dev/null)

# Checking if completions file exists, if not then creating it
if [[ ! -f "/home/builder/autocomplete.sh" ]]; then

  echo -n -e "${C_YELLOW}"
  echo -e "Generating completions..."
  /srv/scripts/general/autocomplete_generator.py
  echo -n -e "${C_RST}"

fi

echo -n -e "${C_RST}"
