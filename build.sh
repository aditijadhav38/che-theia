#!/bin/bash
#
# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# See: https://sipb.mit.edu/doc/safe-shell/
. ./build.include
set -e
set -o pipefail

parse "$@"
yarn ${YARN_OPTS}
export BUILDX=0
if [[ $(check_buildx_support; echo $?) -eq 0 ]]; then
  export BUILDX=1
  buildImages
else
  buildImages
  publishImagesOnQuay
fi

if is_publish_images; then
    publishImages
fi
