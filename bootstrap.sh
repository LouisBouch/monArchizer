#!/bin/bash
set -e

# Run script from location of this script.
cd $(dirname -- "${BASH_SOURCE[0]}")

ansible-galaxy collection install -r ansible/requirements.yml -p ansible/collections

ansible-playbook ansible/bootstrap.yml -K

