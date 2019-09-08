#!/bin/bash
# uninstall option
set -e
CURRENT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
#CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Find engine folder: ${CURRENT_DIR}"
conda install -y yarn -c conda-forge
pip install -r ./engine/requirements/dev.txt
conda install -y jupyter -c conda-forge
conda install -y rsync -c conda-forge
# template this
rsync -r ${CURRENT_DIR}/package.root.json.example ${CURRENT_DIR}/../package.json
rsync -r ${CURRENT_DIR}/template/app ${CURRENT_DIR}/../
rsync -r ${CURRENT_DIR}/.env.example ${CURRENT_DIR}/.env
yarn install
PREV_DIR=$(pwd)
cd ${CURRENT_DIR}/../app/js/
yarn create react-app webapp
${CURRENT_DIR}/node_modules/.bin/json -I -f webapp/package.json -e 'this.proxy="http://localhost:5000"'
cd ${PREV_DIR}
