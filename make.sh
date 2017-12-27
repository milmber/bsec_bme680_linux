#!/bin/sh

set  -eu

. ./make.config

if [ ! -d "${BSEC_DIR}" ]; then
  echo 'BSEC directory missing.'
  exit 1
fi

if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir "${CONFIG_DIR}"
fi

echo 'Compiling...'
cc -Wall -static \
  -iquote"${BSEC_DIR}"/API \
  -iquote"${BSEC_DIR}"/algo \
  -iquote"${BSEC_DIR}"/example \
  "${BSEC_DIR}"/API/bme680.c \
  "${BSEC_DIR}"/example/bsec_integration.c \
  ./bsec_bme680.c \
  -L"${BSEC_DIR}"/"${ARCH}" -lalgobsec \
  -lm -lrt \
  -o bsec_bme680
echo 'Compiled.'

cp "${BSEC_DIR}"/config/"${CONFIG}"/bsec_iaq.config "${CONFIG_DIR}"/
echo 'Copied config.'
