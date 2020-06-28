#!/bin/bash

set -e

./p.sh | grep -i Usage
./p.sh ls | grep -i 'Usage: p ls'
./p.sh ls | grep -i ___p_ls
./p.sh json | grep -i ___p_json
./p.sh j | grep -i 'Usage.*p.*json'
./p.sh json | grep -i 'Usage.*p.*json'
