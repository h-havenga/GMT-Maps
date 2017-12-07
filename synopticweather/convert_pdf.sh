#!/bin/bash

for FILE in ./*.pdf; do
  pdfcrop --margins '-0 -0.5 -0.5 -0' "${FILE}"
done
